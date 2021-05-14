import Foundation
import UIKit

final class TermFieldView: CommonView {
    
    private let arrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "arrow_down")
        
        return imageView
    }()
    
    let termLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    override func addElements() {
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 0.9921568627, alpha: 0.7494549394)
        
        addSubview(arrowView)
        arrowView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(26)
            $0.width.equalTo(13)
            $0.height.equalTo(10)
        }
        
        addSubview(termLabel)
        termLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.trailing.equalToSuperview().offset(10)
            $0.leading.equalTo(arrowView.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
}
