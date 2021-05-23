import Foundation
import UIKit

final class ClassmatesPage: CommonTableViewController {
    
    private let searchBar = UISearchBar()
    
    private var data: [ClassmateModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var isFiltering: Bool { !(filteringQuery?.isEmpty ?? true) }
    
    private var filteredData: [ClassmateModel] = []
    
    var filteringQuery: String? {
        didSet {
            guard let query = filteringQuery?.lowercased(), !query.isEmpty else {
                filteredData.removeAll()
                return
            }
            
            filteredData = data.filter {
                $0.name.lowercased().contains(query) || ($0.id ?? "").lowercased().contains(query)
            }
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
        
        navigationItem.title = "Class"
        
        defaultConfiguration()
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        configureGradientBackgroud()
        configureSearchBar()
        
        data = DataExample.classmates()
    }
    
    override func embedTableView() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "Search"
        searchBar.delegate = self
    }
    
    private func configureGradientBackgroud() {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.2156862745, green: 0.4156862745, blue: 0.9294117647, alpha: 0.2038206762).cgColor, #colorLiteral(red: 0.7215686275, green: 0.3960784314, blue: 0.9215686275, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = view.frame
        
        view.layer.insertSublayer(gradient, at: 0)
    }
}

extension ClassmatesPage: UITableViewDelegate {
    
}

extension ClassmatesPage: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredData.count
        }
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = isFiltering ? filteredData[indexPath.row] : data[indexPath.row]
        
        let position: ClassmateCell.Position
        switch model.position {
        case "teacher":
            position = .teacher
        case "head":
            position = .head
        default:
            position = .common
        }
        
        let cell = ClassmateCell()
        cell.configure(url: model.imgUrl, name: model.name, id: model.id, position: position)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
}

extension ClassmatesPage: UISearchBarDelegate {
    func updateSearchResults(for searchText: String) {
        filteringQuery = searchText
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: searchText)
    }
}
