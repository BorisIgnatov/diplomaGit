import Foundation
import UIKit

final class UpcomingClassScrollCell: ScrollActivityCell {
    
    override var titleText: String {
        "Upcoming Class"
    }
    
    private let classes: [ScheduleModel] = [
        ScheduleModel(location: "class 112", subject: "Mathematics", time: "9:00 AM", teacher: "Kenzhe Zhaliyeva"),
        ScheduleModel(location: "class 302", subject: "Russian", time: "10:00 AM", teacher: "Asiya Akhmetovna"),
        ScheduleModel(location: "class 415", subject: "Biology", time: "11:00 AM", teacher: "Zhanna Arkadiyevna"),
        ScheduleModel(location: "Sport hall", subject: "Physical education", time: "01:00 PM", teacher: "Anna Petrovna"),
    ]
    
    override func registerCell() {
        collectionView.register(UpcomingClassCollectionCell.self,
                                forCellWithReuseIdentifier: UpcomingClassCollectionCell.className)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingClassCollectionCell.className, for: indexPath) as! UpcomingClassCollectionCell
        
        let model = classes[indexPath.row]
        
        cell.configure(duration: "60 min",
                       subject: model.subject,
                       teacher: model.teacher,
                       time: "13 may | \(model.time) AM")
        
        return cell
    }
}
