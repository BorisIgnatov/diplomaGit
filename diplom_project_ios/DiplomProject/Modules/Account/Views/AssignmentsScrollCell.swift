import Foundation
import UIKit

final class AssignmentsScrollCell: ScrollActivityCell {
    
    override var titleText: String {
        "Assignments"
    }
    
    override func registerCell() {
        collectionView.register(AssignmentBoxCollectionCell.self,
                                forCellWithReuseIdentifier: AssignmentBoxCollectionCell.className)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssignmentBoxCollectionCell.className, for: indexPath) as! AssignmentBoxCollectionCell
        
        cell.configure(title: "New assignment: Lecture 12- Human Physic", subject: "Mathematics", desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu nisl magna...", deadline: nil)
        
        return cell
    }
}
