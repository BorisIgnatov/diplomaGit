import Foundation
import SpreadsheetView

final class RowValueCell: Cell, ClassNameable {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var shouldAlignToRight = true {
        didSet {
            guard shouldAlignToRight else {
                label.textAlignment = .natural
                return
            }
            
            label.textAlignment = .right
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        
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
            $0.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
    }
}
