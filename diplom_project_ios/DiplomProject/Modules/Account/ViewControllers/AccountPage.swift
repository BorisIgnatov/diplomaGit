import Foundation
import UIKit

final class AccountPage: CommonTableViewController {
    
    enum CellType {
        case header
        case classmates
        case upcomingClass
        case assignments
    }
    
    private var data: [CellType] = [] {
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
        
        navigationItem.title = "Profile"
        
        defaultConfiguration()
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    private func loadData() {
        data = [.header, .classmates, .upcomingClass, .assignments]
        
        refreshControl.endRefreshing()
    }
    
    private func showClassmatesPage() {
        let vc = ClassmatesPage()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AccountPage: UITableViewDelegate {

}

extension AccountPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data[indexPath.row] {
        case .header:
            let model = AccountModel(icon: "https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg",
                                     name: "Ignatov Boris Alexandrovich", classNum: "10B", idNum: "170107113", bd: "01.01.2004")
            
            let cell = AccountHeaderCell()
            cell.configure(with: model)
            
            return cell
            
        case .classmates:
            let cell = ClassmateScrollCell()
            cell.onMorePressed = { [weak self] in
                self?.showClassmatesPage()
            }
            
            return cell
        case .upcomingClass:
            let cell = UpcomingClassScrollCell()
            cell.onMorePressed = {
                AppRouter.shared.tabBarRouter.showTab(.schedule)
            }
            
            return cell
            
        case .assignments:
            let cell = AssignmentsScrollCell()
            cell.onMorePressed = {
                AppRouter.shared.tabBarRouter.showTab(.classroom)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data[indexPath.row] {
        case .header:
            return 184
        default:
            return UITableView.automaticDimension
        }
    }
    
}
