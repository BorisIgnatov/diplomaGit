import Foundation
import UIKit
import PromiseKit

final class AssignmentDetailedPage: CommonTableViewController {
    
    enum CellType {
        case title
        case separator
        case description
        case attachment
        case apply
    }
    
    private var data: [CellType] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let submitView = SubmitAssignmentView()
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultConfiguration()
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    override func embedTableView() {
        super.embedTableView()
        
        view.addSubview(submitView)
        submitView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func loadData() {
        data = [
            .title,
            .separator,
            .description,
            .attachment,
        ]
        
        refreshControl.endRefreshing()
    }
}

extension AssignmentDetailedPage: UITableViewDelegate {
    
}

extension AssignmentDetailedPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data[indexPath.row] {
        case .title:
            let cell = AssignmentHeaderCell()
            cell.configure(deadline: "Due to 12 march , 2021,  23:59",
                           title: "New assignment: Lecture 12-Human Physic",
                           points: "100 points")
            
            return cell
        case .description:
            let cell = AssignmentDescriptionCell()
            cell.configure(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur at velit mattis, interdum orci id, suscipit ligula. Sed faucibus metus nisl, et cursus nisl gravida et. Morbi interdum, magna vel tempus porttitor, eros augue scelerisque turpis, rutrum consequat mauris justo nec nibh.")
            
            return cell
            
        case .separator:
            return AssignmentSeparatorCell()
        case .attachment:
            return AssignmentAttachmentCell()
        default:
            return UITableViewCell()
        }
    }
    
}
