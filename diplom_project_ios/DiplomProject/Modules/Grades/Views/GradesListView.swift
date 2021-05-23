import UIKit

final class GradesListView: CommonView {
    
    var parts: [GradePart] = [] {
        didSet {
            setParts()
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    override func addElements() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setParts() {
        parts.forEach { part in
            let title = part.partTitle
            let point = part.point
            
            let titleLabel = getLabel()
            let pointLabel = getLabel()
            pointLabel.textAlignment = .right
            
            titleLabel.text = title
            pointLabel.text = point
            
            let view = UIView()
            
            view.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.top.leading.bottom.equalToSuperview()
            }
            
            view.addSubview(pointLabel)
            pointLabel.snp.makeConstraints {
                $0.top.trailing.bottom.equalToSuperview()
                $0.leading.equalTo(titleLabel.snp.trailing)
            }
            
            stackView.addArrangedSubview(view)
        }
    }
    
    private func getLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }
}
