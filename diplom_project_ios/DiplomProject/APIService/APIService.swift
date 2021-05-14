import Foundation
import PromiseKit
import SwiftyJSON

class APIService: NetworkService {
    
    var defaultHeaders: [String: String] {
        return [ : ]
    }
    
    func prolongSession() {
        GlobalTimer.shared.resetTimer()
    }
    
    func request<T: StandardApiResponse>(endpoint: Endpoint,
                                         parameters: [String: Any] = [:],
                                         headers: [String: String] = [:],
                                         method: HTTPRequestMethod = .post) -> Promise<T> {

        prolongSession()

        let allHeaders = defaultHeaders.merging(headers) { _, new in new }

        return firstly {
            request(url: endpoint.fullUrl,
                    method: method,
                    parameters: parameters,
                    headers: allHeaders,
                    timeout: endpoint.timeout)
        }.then {
            self.handleResponse($0.0)
        }
    }

    private func handleResponse<T: StandardApiResponse>(_ json: JSON) -> Promise<T> {
        Promise { seal in
            guard let genericResponse = GenericResponse(from: json) else {
                seal.reject(ApiError.unexpected)
                return
            }

            queue.async {
                do {
                    let data: T = try self.mapData(from: json)
                    seal.fulfill(data)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}

extension APIService {

    func downloadFile(endpoint: Endpoint,
                      method: HTTPRequestMethod = .get,
                      parameters: [String: Any],
                      filename: String,
                      headers: [String: String] = [:]) -> Promise<URL> {

        prolongSession()

        let allHeaders = defaultHeaders.merging(headers) { _, new in new }

        return firstly {
            downloadFile(url: endpoint.fullUrl,
                         filename: filename,
                         method: method,
                         parameters: parameters,
                         headers: allHeaders)
        }.map(on: queue) { (url: URL, json: JSON?, response: HTTPURLResponse?) -> URL in
            return url
        }
    }
}

extension APIService {

    func uploadFile<T: StandardApiResponse>(endpoint: Endpoint,
                                            headers: [String: String]?,
                                            parameters: [String: Any]?,
                                            files: [File],
                                            method: HTTPRequestMethod = .post,
                                            fileParamName: String,
                                            mimeType: String,
                                            progress: ((Progress) -> Void)? = nil) -> Promise<T> {
        prolongSession()

        let allHeaders = defaultHeaders.merging(headers ?? [:]) { _, new in new }

        return firstly {
            uploadFile(url: endpoint.fullUrl,
                       headers: allHeaders,
                       parameters: parameters,
                       files: files,
                       method: method,
                       fileParamName: fileParamName,
                       mimeType: mimeType,
                       progress: progress)
        }.then {
            self.handleResponse($0.0)
        }
    }
}

extension APIService {

    private func mapData<T: StandardApiResponse>(from json: JSON) throws -> T {
        guard let response = T(from: json) else {
            throw ApiError.unexpected
        }

        return response
    }

}
