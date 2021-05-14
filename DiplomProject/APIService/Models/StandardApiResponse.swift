import Foundation

protocol StandardApiResponse: Parseable {
    var statusCode: Int { get }
    var responseCode: ResponseCode { get }
}
