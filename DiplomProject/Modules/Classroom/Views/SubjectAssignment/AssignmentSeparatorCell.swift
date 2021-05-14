import UIKit

final class AssignmentSeparatorCell: CommonTableViewCell {
    
    private let separator = UIView()
    
    override func addElements() {
        separator.backgroundColor = .black
        
        addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.height.equalTo(1)
        }
    }
}
