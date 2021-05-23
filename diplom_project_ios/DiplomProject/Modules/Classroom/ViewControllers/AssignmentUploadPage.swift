import Foundation
import UIKit

final class AssignmentUploadPage: CommonTableViewController {
    
    enum CellType {
        case title
        case separator
        case attachment
        case comment
    }
    
    private var data: [CellType] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var applyButton: UIButton = {
        let button = CommonButton()
        button.setStyle(.purple)
        button.setTitle("+ Add work", for: [])
        
        return button
    }()
    
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
        
    }
    
    override func embedTableView() {
        super.embedTableView()
        
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(-25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-14)
            $0.height.equalTo(50)
        }
    }
    
}

extension AssignmentUploadPage: UITableViewDelegate {
    
}

extension AssignmentUploadPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
