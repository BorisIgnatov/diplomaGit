import Foundation
import UIKit

protocol KeyboardObserverListener: class {
    func keyboardWillShow(withHeight height: CGFloat, animationDuration: TimeInterval)
    func keyboardWillDissappear()
}

final class KeyboardObserver: NSObject {
    
    weak var scrollableView: UIScrollView?

    weak var listener: KeyboardObserverListener?
    
    var bottomOffsetBias: CGFloat = 0
    
    override init() {
        super.init()
        startObservingKeyboardEvents()
    }
    
    func startObservingKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDissappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        let kbFrameKey = UIResponder.keyboardFrameEndUserInfoKey

        guard let keyboardFrame = notification.userInfo?[kbFrameKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomOffset = keyboardHeight + bottomOffsetBias
        scrollableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomOffset, right: 0)

        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey

        if let animationDuration = notification.userInfo?[durationKey] as? TimeInterval {
            listener?.keyboardWillShow(withHeight: keyboardHeight, animationDuration: animationDuration)
        }
    }
    
    @objc func keyboardWillDissappear(_ notification: Notification) {
        scrollableView?.contentInset = .zero
        listener?.keyboardWillDissappear()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
