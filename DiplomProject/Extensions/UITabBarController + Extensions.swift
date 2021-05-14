import UIKit

extension UITabBarController {

    func showTabBar(animated: Bool = true) {
        let y = view.frame.height - tabBar.frame.height
        changeTabBarVerticalPositionAnimated(yPosition: y, animated: animated)
    }

    func hideTabBar(animated: Bool = true) {
        changeTabBarVerticalPositionAnimated(yPosition: view.frame.height, animated: animated)
    }

    private func changeTabBarVerticalPositionAnimated(yPosition: CGFloat, animated: Bool) {
        let tabBarFrame = tabBar.frame
        let newFrame = CGRect(x: 0, y: yPosition, width: tabBarFrame.width, height: tabBarFrame.height)

        func changeTabBarFrame() {
            tabBar.frame = newFrame
        }

        if animated {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                changeTabBarFrame()
            }, completion: nil)
        } else {
            changeTabBarFrame()
        }
    }

}
