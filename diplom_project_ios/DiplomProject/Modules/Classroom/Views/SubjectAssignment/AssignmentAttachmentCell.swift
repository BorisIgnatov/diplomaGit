import UIKit

final class AssignmentAttachmentCell: CommonTableViewCell {
    
    var onSelect: ((Int) -> Void)?
    
    var files: [FileModel] = [
        FileModel(filename: "Car.data", url: ""),
        FileModel(filename: "hw.txt", url: ""),
        FileModel(filename: "data.xlx", url: ""),
    ]
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "Attachment"
        
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func addElements() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
        }
        
        embedCollectionView()
    }
    
    func embedCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().offset(-19)
            $0.height.equalTo(130)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AttachmentCollectionCell.self, forCellWithReuseIdentifier: AttachmentCollectionCell.className)
    }
}
extension AssignmentAttachmentCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 80, height: 104)
    }
}

extension AssignmentAttachmentCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttachmentCollectionCell.className, for: indexPath) as! AttachmentCollectionCell
        
        cell.configure(name: files[indexPath.row].filename)
        
        return cell
    }
}

extension AssignmentAttachmentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(indexPath.row)
    }
}
