import Foundation
import UIKit

final class SchedulePage: CommonTableViewController {
    
    private lazy var headerSelectionView: UIView = {
        let view = DaySelectionView()
        view.onSelection = { [weak self] day in
            self?.dayChanged(day)
        }
        
        return view
    }()
    
    var data: [ScheduleModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Schedule"
        
        defaultConfiguration()
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        configureGradientBackgroud()
        
        dayChanged("MON")
    }
    
    private func configureGradientBackgroud() {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.2156862745, green: 0.4156862745, blue: 0.9294117647, alpha: 0.2038206762).cgColor, #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.9215686275, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = view.frame
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func dayChanged(_ dayValue: String) {
        
        let models: [ScheduleModel]
            
        if dayValue == "MON" {
            models = [
                ScheduleModel(location: "class 112", subject: "Mathematics", time: "9:00 AM — 10:00 AM", teacher: "Kenzhe Zhaliyeva"),
                ScheduleModel(location: "class 302", subject: "Russian", time: "10:00 AM — 11:00 AM", teacher: "Asiya Akhmetovna"),
                ScheduleModel(location: "class 415", subject: "Biology", time: "11:00 AM — 01:00 PM", teacher: "Zhanna Arkadiyevna"),
                ScheduleModel(location: "Sport hall", subject: "Physical education", time: "01:00 PM — 02:00 PM", teacher: "Anna Petrovna"),
            ]
        } else {
            models = [
                ScheduleModel(location: "class 110", subject: "Geometry", time: "9:00 AM — 10:00 AM", teacher: "Kenzhe Zhaliyeva"),
                ScheduleModel(location: "class 401", subject: "Kazakh", time: "10:00 AM — 11:00 AM", teacher: "Makpal Zhunusovna"),
                ScheduleModel(location: "class 215", subject: "Chemistry", time: "11:00 AM — 01:00 PM", teacher: "Abylai Erkingalievich"),
                ScheduleModel(location: "Red hall", subject: "Presentation skills", time: "01:00 PM — 02:00 PM", teacher: "Dmitry Yun"),
                ScheduleModel(location: "Act hall", subject: "Exam Rules", time: "02:00 PM — 03:00 PM", teacher: "Rahim Ibragivomich"),
            ]
        }
        
        data = models
    }
}

extension SchedulePage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerSelectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        65
    }
}

extension SchedulePage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScheduleCell()
        
        let color: UIColor
        switch data[indexPath.row].subject {
        case "Mathematics":
            color = .red
        case "Russian":
            color = .green
        default:
            color = .orange
        }
        
        cell.configure(with: data[indexPath.row], color: color)
        return cell
    }
    
}
