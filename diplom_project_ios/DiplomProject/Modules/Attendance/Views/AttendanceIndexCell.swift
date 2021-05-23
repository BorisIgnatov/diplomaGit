import Foundation
import SpreadsheetView

final class AttendanceIndexCell: Cell, ClassNameable {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addElements()
    }
    
    private func addElements() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 26, left: 18, bottom: 26, right: 18))
        }
    }
}
