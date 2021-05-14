import Foundation
import UIKit

final class TextFieldView: UIView {
    
    private static let animationDuration = 0.15
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var text: String? {
        get {
            textField.text
        } set {
            textField.text = newValue
        }
    }
    
    var type: FieldType = .text {
        didSet {
            iconView.image = type.icon
            
            switch type {
            case .id:
                textField.keyboardType = .numberPad
            case .password:
                textField.isSecureTextEntry = true
                textField.clearButtonMode = .whileEditing
            default:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        backgroundColor = .white
        
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.04705882353, green: 0.04705882353, blue: 0.1098039216, alpha: 0.39)
        
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(14)
            $0.top.equalToSuperview().offset(13)
            $0.bottom.equalToSuperview().offset(-13)
            $0.trailing.equalToSuperview().offset(-14)
        }
        
        setupAccessoryView()
    }
    
    private func setupAccessoryView() {
        let doneAccessoryView = DoneAccessoryView()
        
        let screenWidth = UIScreen.main.bounds.width
        doneAccessoryView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        
        doneAccessoryView.doneButtonAction = { [weak self] in
            self?.textField.resignFirstResponder()
        }

        textField.inputAccessoryView = doneAccessoryView
    }
}

extension TextFieldView {
    enum FieldType {
        case id, password, text
        
        var icon: UIImage? {
            switch self {
            case .id:
                return #imageLiteral(resourceName: "id-textfield")
            case .password:
                return #imageLiteral(resourceName: "pass-textfield")
            default:
                return nil
            }
        }
    }
}
