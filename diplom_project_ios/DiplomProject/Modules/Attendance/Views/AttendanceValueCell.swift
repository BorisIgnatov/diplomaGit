import Foundation
import SpreadsheetView
import UIKit

final class AttendanceValueCell: Cell, ClassNameable {
    
    var isPresent: Bool = true {
        didSet {
            if isPresent {
                imageView.image = #imageLiteral(resourceName: "present-icon")
            } else {
                imageView.image = #imageLiteral(resourceName: "absent-icon")
            }
        }
    }
    
    private let imageView = UIImageView()
    
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
        imageView.image = #imageLiteral(resourceName: "present-icon")
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 14, left: 13, bottom: 14, right: 3))
        }
    }
}
