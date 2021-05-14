import Foundation
import UIKit

class CommonTableViewController: CommonViewController {
    
    let tableView: UITableView
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        return refresh
    }()

    lazy var keyboardObserver: KeyboardObserver = {
        let ko = KeyboardObserver()
        ko.scrollableView = tableView
        ko.bottomOffsetBias = 32
        return ko
    }()
    
    init(style: UITableView.Style = .plain) {
        tableView = UITableView(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)

        if style == .grouped {
            setupForGroupedStyle()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedTableView()
    }

    private func setupForGroupedStyle() {
        var headerFrame = CGRect.zero
        headerFrame.size.height = CGFloat.leastNonzeroMagnitude
        let headerView = UIView(frame: headerFrame)
        tableView.tableHeaderView = headerView

        tableView.backgroundColor = .white
    }

    func defaultConfiguration() {
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension

        tableView.estimatedSectionHeaderHeight = 0
        tableView.sectionHeaderHeight = UITableView.automaticDimension

        tableView.estimatedSectionFooterHeight = 0
        tableView.sectionFooterHeight = UITableView.automaticDimension

        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()

        tableView.keyboardDismissMode = .onDrag
    }
    
    func embedTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func embedRefreshControl(backgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
        tableView.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)

        var frame = view.bounds
        frame.origin.y = -view.frame.height

        let backgroundView = UIView(frame: frame)

        backgroundView.autoresizingMask = .flexibleWidth
        backgroundView.backgroundColor = backgroundColor

        tableView.insertSubview(backgroundView, at: 0)
    }

    @objc func pulledToRefresh() {
    }
}
