import UIKit

class TermSelectionViewController: CardPresentableViewController {

    let tableView = UITableView()

    var data = [TermGradesModel]()
    var selectedTermModel: TermGradesModel?

    var onSelectTerm: ((TermGradesModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension

        tableView.tableFooterView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 60
        ))
    }

    override func setupView() {
        super.setupView()

        containerView.addSubview(tableView)

        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        doneButton.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        doneButton.setTitle("Cancel", for: [])
        doneButton.titleLabel?.font = .systemFont(ofSize: 17)
    }

}

extension TermSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        
        let cell = TermSelectionCell()
        cell.termTitle = model.termTitle
        cell.isSelectedCell = (model.termTitle == selectedTermModel?.termTitle)

        return cell
    }

}

extension TermSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = data[indexPath.row]

        dismiss(animated: true) {
            self.onSelectTerm?(model)
        }
    }

}
