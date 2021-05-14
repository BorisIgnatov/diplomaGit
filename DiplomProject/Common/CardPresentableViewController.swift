import Foundation
import UIKit

class CardPresentableViewController: CommonViewController {

    override var hidesNavigationBar: Bool { true }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private let td = CardTransitioningDelegate()

    let topContainerView = UIView()
    let containerView = UIView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    let doneButton = UIButton()

    private var panGestureRecognizer: UIPanGestureRecognizer!

    private var firstTouchY: CGFloat = 0

    convenience init() {
        self.init(nibName: nil, bundle: nil)

        if #available(iOS 13, *) {} else {
            modalPresentationStyle = .custom
            modalPresentationCapturesStatusBarAppearance = true
            transitioningDelegate = td
            addGestureRecognizer()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        view.addSubview(topContainerView)

        topContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }

        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(topContainerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        topContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().priority(750)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }

        doneButton.setTitle("Done", for: [])
        doneButton.setTitleColor(Color.purple, for: [])
        doneButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        doneButton.addTarget(self, action: #selector(doneBarButtonTapped), for: .touchUpInside)

        topContainerView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16)
        }

        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.7333333333, blue: 0.7568627451, alpha: 1)
        topContainerView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }

    private func addGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        topContainerView.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let yPosition = gestureRecognizer.translation(in: view).y

        switch gestureRecognizer.state {
        case .began:
            firstTouchY = yPosition
        case .changed:
            let distanceTravelled = yPosition - firstTouchY
            guard distanceTravelled > 0 else { return }
            adjustCardPosition(yOffset: distanceTravelled)
        case .ended:
            let distanceTravelled = yPosition - firstTouchY

            guard distanceTravelled > 0 else { return }

            let halfOfScreen = (view.frame.height / 2)
            let yVelocity = gestureRecognizer.velocity(in: view).y

            if distanceTravelled > halfOfScreen || yVelocity > 2000 {
                dismiss(animated: true, completion: nil)
                return
            }
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.adjustCardPosition(yOffset: CGFloat(0))
            }, completion: nil)
        default:
            break
        }
    }

    @objc private func doneBarButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension CardPresentableViewController: UIScrollViewDelegate {

    private func adjustCardPosition(yOffset: CGFloat) {
        guard let presentationController = presentationController as? CardPresentationController else { return }
        presentationController.updateCardViews(topOffset: yOffset, viewsHeight: view.frame.height)
    }

}
