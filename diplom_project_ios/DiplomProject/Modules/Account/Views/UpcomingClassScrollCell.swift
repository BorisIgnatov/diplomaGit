import Foundation
import UIKit

final class UpcomingClassScrollCell: ScrollActivityCell {
    
    override var titleText: String {
        "Upcoming Class"
    }
    
    override func registerCell() {
        collectionView.register(UpcomingClassCollectionCell.self,
                                forCellWithReuseIdentifier: UpcomingClassCollectionCell.className)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingClassCollectionCell.className, for: indexPath) as! UpcomingClassCollectionCell
        
        cell.configure(duration: "30 min",
                       subject: "Mathematics",
                       teacher: "Kenzhe Zhaliyeva",
                       time: "13 may | 9:00 AM")
        
        return cell
    }
}
