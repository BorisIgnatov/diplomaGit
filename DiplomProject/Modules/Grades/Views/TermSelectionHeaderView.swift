import Foundation
import UIKit

final class TermSelectionHeaderView: CommonView {
    
    var onTap: (() -> Void)?
    
    var selectedTermTitle: String? {
        didSet {
            termView.termLabel.text = selectedTermTitle
        }
    }
    
    private let termView: TermFieldView = {
        let view = TermFieldView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "Klyksa")
        
        return imageView
    }()
    
    override func addElements() {
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bgImageView.addSubview(termView)
        termView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.bottom.equalToSuperview().offset(-36)
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(recognizer)
    }
    
    @objc
    private func didTap() {
        onTap?()
    }
}
