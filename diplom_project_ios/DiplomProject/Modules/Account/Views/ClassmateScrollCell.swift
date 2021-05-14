import UIKit

final class ClassmateScrollCell: ScrollActivityCell {
    
    override var titleText: String {
        "Class 10B:"
    }
    
    override func addElements() {
        super.addElements()
        
        collectionView.snp.updateConstraints {
            $0.height.equalTo(80)
        }
    }
    
    override func registerCell() {
        collectionView.register(ClassmateCollectionCell.self,
                                forCellWithReuseIdentifier: ClassmateCollectionCell.className)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 54, height: 79)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassmateCollectionCell.className, for: indexPath) as! ClassmateCollectionCell
        
        switch indexPath.row {
        case 0:
            cell.configure(name: "Saule Turmanova", avatar: "https://i.pinimg.com/originals/70/52/1e/70521e688d924112848396ec220a517b.png", position: .teacher)
        case 1:
            cell.configure(name: "Daulet Sergazin", avatar: "https://i.pinimg.com/originals/70/52/1e/70521e688d924112848396ec220a517b.png", position: .head)
        default:
            cell.configure(name: "Boris Ignatov", avatar: "https://i.pinimg.com/originals/70/52/1e/70521e688d924112848396ec220a517b.png", position: .common)
        }
        
        return cell
    }
}

