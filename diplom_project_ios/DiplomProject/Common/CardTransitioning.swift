import Foundation
import UIKit

private var baseDimmingColor: UIColor { return UIColor.black }
private var dimmingColorAlpha: CGFloat { return 0.32 }
private let scaleFactor: CGFloat = 0.9

final class CardPresentationController: UIPresentationController {

    private let presentingContainerView = PresentingContainerView()

    override func presentationTransitionWillBegin() {

        guard let snapshot = presentingViewController.view.snapshotView(afterScreenUpdates: true) else { return }

        presentingContainerView.addSubview(snapshot)
        snapshot.snp.makeConstraints { $0.edges.equalToSuperview() }

        containerView?.addSubview(presentingContainerView)
        presentingContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        presentingContainerView.addDimerView()
        presentingContainerView.dimmerView.alpha = 0

        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.presentingContainerView.dimmerView.alpha = 1
        }, completion: nil)

        presentingViewController.view.isHidden = true
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.presentingContainerView.dimmerView.alpha = 0
        }, completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.view.isHidden = false
    }

}

extension CardPresentationController {

    func updateCardViews(topOffset: CGFloat, viewsHeight: CGFloat) {
        let topOffsetAbs = abs(topOffset)

        presentedView?.transform = CGAffineTransform(translationX: 0, y: topOffsetAbs)

        let proportionOfDistanceCovered = topOffset/viewsHeight
        let presentingContainerViewScale = (1 - scaleFactor) * proportionOfDistanceCovered + scaleFactor
        let scale = min(presentingContainerViewScale, 1)

        presentingContainerView.transform = CGAffineTransform(scaleX: scale, y: scale)

        let dimmingBias: CGFloat = 0.1
        let dimmingAlpha = min(1 - proportionOfDistanceCovered - dimmingBias, dimmingColorAlpha)

        presentingContainerView.dimmerView.backgroundColor = baseDimmingColor.withAlphaComponent(dimmingAlpha)
    }

}


final class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CardPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = CardAnimationController()
        animationController.mode = .presentation
        return animationController
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = CardAnimationController()
        animationController.mode = .dismissal
        return animationController
    }

}

final class CardAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var transitionDuration: TimeInterval = 0.25

    enum Mode {
        case presentation, dismissal
    }

    var mode: Mode = .presentation

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let toVc = transitionContext.viewController(forKey: .to)!

        let fromVc = transitionContext.viewController(forKey: .from)!

        let finalFrame = transitionContext.finalFrame(for: toVc)

        let presentingContainerView = transitionContext.containerView.subviews.first { $0 is PresentingContainerView }!

        if mode == .presentation {
            transitionContext.containerView.addSubview(toVc.view)
            toVc.view.frame = CGRect(x: 0, y: finalFrame.height * 0.8, width: finalFrame.width, height: finalFrame.height)
        }

        let animationDuration = transitionDuration(using: transitionContext)

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: animationDuration, delay: 0, options: .curveLinear, animations: {
            switch self.mode {
            case .presentation:
                self.animateTransition(fromView: presentingContainerView, toView: toVc.view, finalFrame: finalFrame)
            case .dismissal:
                self.animateDismissal(fromView: fromVc.view, toView: presentingContainerView, finalFrame: finalFrame)
            }
        }) { position in
            transitionContext.completeTransition(position == .end)
        }
    }

    private func animateTransition(fromView: UIView, toView: UIView, finalFrame: CGRect) {
        fromView.layer.cornerRadius = 8
        fromView.layer.masksToBounds = true

        let transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        fromView.transform = transform

        let toViewYOrigin = finalFrame.midY * (1 - scaleFactor) + 8
        toView.frame = CGRect(x: 0, y: toViewYOrigin, width: finalFrame.width, height: finalFrame.height - toViewYOrigin)
        toView.layer.cornerRadius = 10
        toView.layer.masksToBounds = true
    }

    private func animateDismissal(fromView: UIView, toView: UIView, finalFrame: CGRect) {
        fromView.frame.origin = CGPoint(x: 0, y: finalFrame.height)
        toView.transform = .identity
    }

}

private final class PresentingContainerView: UIView {

    lazy var dimmerView: UIView = {
        let dimmer = UIView()
        dimmer.backgroundColor = baseDimmingColor.withAlphaComponent(dimmingColorAlpha)
        return dimmer
    }()

    func addDimerView() {
        addSubview(dimmerView)
        dimmerView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
