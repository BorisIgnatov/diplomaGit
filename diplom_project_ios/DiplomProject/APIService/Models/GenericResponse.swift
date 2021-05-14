import SwiftyJSON

class GenericResponse: StandardApiResponse {

    let statusCode: Int
    
    var responseCode: ResponseCode {
        return ResponseCode(code: statusCode)
    }

    required init?(from json: JSON) {
        guard let code = json["StatusCode"].int else { return nil }
        statusCode = code
    }

}

final class StatusResponse: GenericResponse {
    let systemStatus: Int
    
    var isStatusOk: Bool {
        return systemStatus == 0 && statusCode == 0
    }
    
    required init?(from json: JSON) {
        systemStatus = json["Data"]["Status"].int ?? -777
        super.init(from: json)
    }
}
