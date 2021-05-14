import Foundation
import UIKit

class CommonTableViewCell: UITableViewCell, ClassNameable {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    init(style: UITableViewCell.CellStyle = .default) {
        super.init(style: style, reuseIdentifier: nil)
        addElements()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func addElements() {
    }
}
