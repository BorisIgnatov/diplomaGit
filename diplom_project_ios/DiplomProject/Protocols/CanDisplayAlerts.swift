import Foundation
import UIKit

protocol CanDisplayAlerts {
}

extension CanDisplayAlerts where Self: UIViewController {
    
    func showAlert(title: String?,
                   message: String?,
                   style: UIAlertController.Style,
                   actions: [UIAlertAction],
                   preferredAction: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

        if let action = preferredAction {
            alertController.addAction(action)
            alertController.preferredAction = action
        }

        actions.forEach { alertController.addAction($0) }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithCancelAction(title: String?,
                                   message: String?,
                                   style: UIAlertController.Style = .alert,
                                   actions: [UIAlertAction] = []) {
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        var alertActions = actions
        alertActions.append(cancelAction)
        showAlert(title: title, message: message, style: style, actions: alertActions)
    }
    
    func showAlertWithOkAction(title: String?,
                               message: String?,
                               style: UIAlertController.Style = .alert,
                               actions: [UIAlertAction] = [],
                               okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: okActionHandler)
        var alertActions = actions
        alertActions.append(okAction)
        showAlert(title: title, message: message, style: style, actions: alertActions)
    }

    func showAttributedAlert(title: String?,
                             attributedMessage: NSAttributedString?,
                             style: UIAlertController.Style,
                             actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: style)

        actions.forEach { alertController.addAction($0) }

        alertController.preferredAction = actions.last
        alertController.setValue(attributedMessage, forKey: "attributedMessage")

        present(alertController, animated: true, completion: nil)
    }

}

extension CanDisplayAlerts where Self: UIViewController {

    func displayError(_ error: Error, completion: ((UIAlertAction) -> Void)? = nil) {
        var title = "Ошибка"
        var message = error.localizedDescription

        if !Network.shared.reachable(error) {
            title = Network.noConnectionTitle
            message = Network.noConnectionMessage
        } else if case ApiError.detailed(statusCode: _, message: let msg, description: let description) = error {
            if !msg.isEmpty && !description.isEmpty {
                title = msg
                message = description
            }
        }
        
        showAlertWithOkAction(title: title, message: message, okActionHandler: completion)
    }

}
