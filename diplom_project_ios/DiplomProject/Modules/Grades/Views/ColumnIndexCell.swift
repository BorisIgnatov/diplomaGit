import Foundation
import SpreadsheetView

final class ColumnIndexCell: Cell, ClassNameable {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
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
        backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
    }
}
