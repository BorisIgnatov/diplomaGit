import UIKit

final class CameraView: CommonView {
    
    var openCamera: (() -> Void)?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "camera-icon")
        
        return imageView
    }()
    
    override func addElements() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.equalTo(78)
            $0.height.equalTo(71)
            $0.centerX.equalToSuperview()
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(cameraDidTap))
        imageView.addGestureRecognizer(recognizer)
    }
    
    @objc
    private func cameraDidTap() {
        openCamera?()
    }
}
