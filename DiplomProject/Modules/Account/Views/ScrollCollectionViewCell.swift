import UIKit

class ScrollCollectionViewCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 28
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func embedContainer() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        setShadows()
        
        addElements()
    }
    
    private func setShadows() {
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    }
    
    func addElements() {
        
    }
}
