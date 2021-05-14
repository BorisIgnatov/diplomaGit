import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class NetworkService: ClassNameable {

    typealias NetworkResponse = (JSON, HTTPURLResponse?)

    enum NetworkServiceError: LocalizedError {
        case requestCreationFailure
    }

    let queue = DispatchQueue(label: className,
                              qos: .default,
                              attributes: .concurrent,
                              autoreleaseFrequency: .workItem)
}

extension NetworkService {

    func request(url: String,
                 method: HTTPRequestMethod,
                 parameters: [String: Any],
                 headers: [String: String],
                 timeout: TimeInterval = 30) -> Promise<NetworkResponse> {

        return Promise<NetworkResponse> { seal in
            guard let request = buildUrlRequest(url: url,
                                                method: method,
                                                parameters: parameters,
                                                headers: headers,
                                                timeoutInterval: timeout)
            else {
                return seal.reject(NetworkServiceError.requestCreationFailure)
            }

            performAfRequest(request: request, seal: seal)
        }
    }

    private func buildUrlRequest(url: String,
                                 method: HTTPRequestMethod,
                                 parameters: [String: Any],
                                 headers: [String: String],
                                 timeoutInterval: TimeInterval) -> URLRequest? {
        guard let requestUrl = URL(string: url) else { return nil }

        var request = URLRequest(url: requestUrl,
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: timeoutInterval)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        let paramEncoding = encoding(for: method)

        let encodedURLRequest = try? paramEncoding.encode(request, with: parameters)
        return encodedURLRequest
    }

    private func encoding(for method: HTTPRequestMethod) -> ParameterEncoding {
        switch method {
        case .get,
             .head,
             .delete:
            return URLEncoding(destination: .methodDependent,
                               arrayEncoding: .noBrackets,
                               boolEncoding: .literal)
        default:
            return JSONEncoding.default
        }
    }

    private func performAfRequest(request: Alamofire.URLRequestConvertible, seal: Resolver<NetworkResponse>) {
        AF.request(request).validate().responseData(queue: queue) { [weak self] response in

            switch response.result {
            case .success(let result):
                let json = JSON(result)
                seal.fulfill((json, response.response))
                self?.printRequest(response: response)
            case .failure(let error):
                let networkError = error.underlyingError ?? error

                if !Network.shared.reachable(networkError) {
                    seal.reject(networkError)
                } else {
                    let defaultError = ApiError.detailed(statusCode: .unknown(code: -999),
                                                         message: "Сервис временно недоступен",
                                                         description: "Попробуйте позже.")
                    
                    seal.reject(defaultError)
                }
            }
        }
    }
}

extension NetworkService {

    struct File {
        let data: Data
        let filename: String
    }

    func uploadFile(url: String,
                    headers: [String: String]?,
                    parameters: [String: Any]?,
                    files: [File],
                    method: HTTPRequestMethod,
                    fileParamName: String,
                    mimeType: String,
                    progress: ((Progress) -> Void)? = nil) -> Promise<NetworkResponse> {

        return Promise<NetworkResponse> { seal in

            let multipart = prepareMultipartData(files: files,
                                                 fileParamName: fileParamName,
                                                 mimeType: mimeType,
                                                 parameters: parameters)

            var httpHeaders: HTTPHeaders?

            if let headers = headers {
                httpHeaders = HTTPHeaders(headers)
            }

            let progressHandler = progress ?? { _ in }

            let httpMethod = HTTPMethod(rawValue: method.rawValue)

            AF.upload(multipartFormData: multipart, to: url,
                      method: httpMethod,
                      headers: httpHeaders)
                .responseJSON(queue: queue) { response in

                    switch response.result {
                    case .success(let result):
                        let json = JSON(result)
                        seal.fulfill((json, response.response))
                    case .failure(let error):
                        seal.reject(error.underlyingError ?? error)
                    }
            }.uploadProgress(closure: progressHandler)
        }
    }

    private func prepareMultipartData(files: [File],
                                      fileParamName: String,
                                      mimeType: String,
                                      parameters: [String: Any]?) -> ((MultipartFormData) -> Void) {
        let multipart: ((MultipartFormData) -> Void) = { form in
            for dataPart in files {
                form.append(dataPart.data, withName: fileParamName, fileName: dataPart.filename, mimeType: mimeType)
            }

            if let parameters = parameters {
                for (key, value) in parameters {
                    let json = JSON(value)
                    switch json.type {
                    case .dictionary:
                        guard let data = try? json.rawData() else { continue }
                        form.append(data, withName: key)
                    default:
                        guard let data = String(describing: value).data(using: .utf8) else { continue }
                        form.append(data, withName: key)
                    }
                }
            }
        }

        return multipart
    }
}

extension NetworkService {

    func downloadFile(url: String,
                      filename: String,
                      method: HTTPRequestMethod,
                      parameters: [String: Any],
                      headers: [String: String] = [:],
                      timeout: TimeInterval = 60) -> Promise<(URL, JSON?, HTTPURLResponse?)> {

        return Promise { seal in

            let destination: DownloadRequest.Destination = { _, _ in
                var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                documentsURL.appendPathComponent(filename)

                return (documentsURL, [.removePreviousFile])
            }

            guard let request = buildUrlRequest(url: url,
                                                method: method,
                                                parameters: parameters,
                                                headers: headers,
                                                timeoutInterval: timeout)
            else {
                return seal.reject(NetworkServiceError.requestCreationFailure)
            }

            AF.download(request, to: destination).responseData(queue: queue) { (response: AFDownloadResponse<Data>) in

                var json: JSON?

                if let data = response.value {
                    json = JSON(data)
                }

                if let destinationURL = response.fileURL {
                    seal.fulfill((destinationURL, json, response.response))
                } else if let error = response.error {
                    seal.reject(error.underlyingError ?? error)
                } else {
                    seal.reject(ApiError.unexpected)
                }
            }
        }
    }
}

extension NetworkService {

    private func printRequest(response: AFDataResponse<Data>) {
        let url = response.response?.url?.absoluteString ?? ""
        let params = JSON(response.request?.httpBody ?? Data())
        let result = JSON(response.value ?? Data())

        let requestStr = "\n\(url)\n🙏🏻\n\(params.description)\n🙌🏼\n\(result.description)"
        print(requestStr)
    }
    
}
