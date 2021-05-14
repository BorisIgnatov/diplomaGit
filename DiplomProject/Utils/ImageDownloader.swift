import Foundation
import Kingfisher
import PromiseKit

final class ImageDownloader {

    static let shared = ImageDownloader()

    private init() {}

    func downloadImage(urlStr: String, headers: [String: String] = [:]) -> Promise<UIImage> {

        guard let url = URL(string: urlStr) else {
            return Promise.init(error: PMKError.badInput)
        }

        let modifier = AnyModifier {
            var request = $0
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }

            return request
        }

        let kfOptions: KingfisherOptionsInfo = [.cacheOriginalImage, .requestModifier(modifier)]

        return Promise { seal in
            KingfisherManager.shared.retrieveImage(with: url, options: kfOptions, progressBlock: nil) { result in
                switch result {
                case .success(let imageResult):
                    seal.fulfill(imageResult.image)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

}
