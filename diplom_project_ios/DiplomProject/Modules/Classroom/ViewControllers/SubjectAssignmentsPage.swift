import Foundation
import UIKit

final class SubjectAssignmentsPage: CommonTableViewController {
    private var isLoading = false
    
    private var data: [AssignmentModel] = [] {
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
        
        navigationItem.title = "Assignments"
        
        defaultConfiguration()
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
        
        embedRefreshControl()
        configureGradientBackgroud()
    }
    
    override func pulledToRefresh() {
        loadData()
    }
    
    private func configureGradientBackgroud() {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.2156862745, green: 0.4156862745, blue: 0.9294117647, alpha: 0.2038206762).cgColor, #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.9215686275, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = view.frame
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func loadData() {
        data = [
            AssignmentModel(title: "New assignment: Lecture 12-Human Physic",
                            subject: "Mathematic",
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu nisl magna...",
                            date: "12 march , 2021",
                            deadline: "",
                            status: .submitted),
            AssignmentModel(title: "New assignment: Lecture 12-Human Physic",
                            subject: "Mathematic",
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu nisl magna...",
                            date: "12 march , 2021",
                            deadline: "2 days left",
                            status: .waiting),
            AssignmentModel(title: "New assignment: Lecture 12-Human Physic",
                            subject: "Mathematic",
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu nisl magna...",
                            date: "12 march , 2021",
                            deadline: "2 days left",
                            status: .waiting),
        ]
        
        refreshControl.endRefreshing()
    }
}

extension SubjectAssignmentsPage: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AssignmentDetailedPage()
        vc.navigationItem.title = data[indexPath.row].subject
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SubjectAssignmentsPage: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AssignmentCell()
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
