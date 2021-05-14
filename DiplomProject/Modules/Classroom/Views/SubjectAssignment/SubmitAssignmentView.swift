import UIKit

final class SubmitAssignmentView: CommonView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        
        return view
    }()
    
    private let workLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        label.text = "Your work"
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.9607843137, green: 0.2156862745, blue: 0.1764705882, alpha: 1)
        label.text = "Missing"
        
        return label
    }()
    
    private lazy var addButton: CommonButton = {
        let button = CommonButton()
        button.setStyle(.purple)
        button.setTitle("+ Add work", for: [])
        
        return button
    }()
    
    override func addElements() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(workLabel)
        workLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(26)
        }
        
        containerView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.trailing.equalToSuperview().offset(-19)
        }
        
        containerView.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(23)
            $0.trailing.equalToSuperview().offset(-23)
            $0.top.equalTo(workLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        setShadows()
    }
    
    private func setShadows() {
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    }
}
