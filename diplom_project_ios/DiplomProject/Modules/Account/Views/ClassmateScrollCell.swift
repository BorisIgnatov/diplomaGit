import UIKit

final class ClassmateScrollCell: ScrollActivityCell {
    
    override var titleText: String {
        "Class 10B:"
    }
    
    private let mates: [ClassmateModel] = DataExample.classmates()
    
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
        return mates.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 54, height: 79)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassmateCollectionCell.className, for: indexPath) as! ClassmateCollectionCell
        
        let position: ClassmateBoxView.BoxType
        switch mates[indexPath.row].name {
        case "Turmanova Saule":
            position = .teacher
        default:
            position = .common
        }
        
        cell.configure(name: mates[indexPath.row].name, avatar: mates[indexPath.row].imgUrl, position: position)
        
        return cell
    }
}

