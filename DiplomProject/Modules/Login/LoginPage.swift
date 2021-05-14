import Foundation
import UIKit

final class LoginPage: CommonViewController {
    
    private let loginButton: UIButton = {
        let button = CommonButton()
        button.setStyle(.purple)
        button.setTitle("Continue", for: [])
        
        return button
    }()
    
    private let navigationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Sign in"
        label.textAlignment = .center
        
        return label
    }()
    
    private let idInputView: UIView = {
        let view = TextFieldView()
        view.placeholder = "Id"
        view.type = .id
        
        return view
    }()
    
    private let passwordInputView: UIView = {
        let view = TextFieldView()
        view.placeholder = "Password"
        view.type = .password
        
        return view
    }()
    
    private let forgotPassButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.04705882353, green: 0.04705882353, blue: 0.1098039216, alpha: 1), for: [])
        button.setTitle("Forgot password?", for: [])
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        addAppearences()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 24
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubview(navigationLabel)
        stackView.addArrangedSubview(idInputView)
        stackView.addArrangedSubview(passwordInputView)
        
        view.addSubview(forgotPassButton)
        forgotPassButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-35)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(44)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(135)
            $0.width.equalTo(250)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        forgotPassButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
    }
    
    private func addAppearences() {
        let topImageView = UIImageView()
        topImageView.contentMode = .scaleToFill
        topImageView.image = #imageLiteral(resourceName: "login-top-klyaksa")
        
        let bottomImageView = UIImageView()
        bottomImageView.contentMode = .scaleToFill
        bottomImageView.image = #imageLiteral(resourceName: "login-botton-klyaksa")
        
        view.addSubview(topImageView)
        topImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(239)
        }
        
        view.addSubview(bottomImageView)
        bottomImageView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.height.equalTo(195)
            $0.width.equalTo(115)
        }
        
    }
    
    @objc
    private func loginButtonTapped() {
        AppRouter.shared.proceedToApp()
    }
    
    @objc
    private func forgotButtonTapped() {
        
    }
}
