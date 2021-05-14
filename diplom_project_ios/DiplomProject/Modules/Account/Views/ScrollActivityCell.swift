import Foundation
import UIKit

class ScrollActivityCell: CommonTableViewCell {
    
    var onSelect: ((Int) -> Void)?
    var onMorePressed: (() -> Void)?
    
    var titleText: String {
        ""
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = titleText
        
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .right
        button.setTitle("More", for: [])
        button.setTitleColor(.black, for: [])
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func addElements() {
        registerCell()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(19)
        }
        
        contentView.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(44)
        }
        
        embedCollectionView()
    }
    
    func embedCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.bottom.equalToSuperview().offset(-19)
            $0.height.equalTo(160)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc
    private func moreButtonTapped() {
        onMorePressed?()
    }
    
    func registerCell() {
    }
}

extension ScrollActivityCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 136, height: 144)
    }
}

extension ScrollActivityCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension ScrollActivityCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(indexPath.row)
    }
}
