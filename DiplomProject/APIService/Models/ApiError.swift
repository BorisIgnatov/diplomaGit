import Foundation

enum ApiError: LocalizedError {
    case unexpected
    case detailed(statusCode: ResponseCode, message: String, description: String)

    var errorDescription: String? {
        let defaultMessage = "Сервис временно недоступен. Попробуйте позже"

        switch self {
        case .unexpected:
            return defaultMessage
        case .detailed(_, let message, let description):
            var errorDescription = message

            if !description.isEmpty {
                errorDescription += "\n\(description)"
            }

            return errorDescription
        }
    }
}
