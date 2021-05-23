import Foundation
import UIKit
import SpreadsheetView

final class GradesListPage: CommonViewController {
    
    private lazy var headerView: TermSelectionHeaderView = {
        let view = TermSelectionHeaderView()
        view.onTap = { [weak self] in
            self?.openSelection()
        }
        
        return view
    }()
    
    private lazy var currentlySelectedTerm: TermGradesModel? = terms.first {
        didSet {
            headerView.selectedTermTitle = currentlySelectedTerm?.termTitle
            spreadsheetView.reloadData()
        }
    }
    
    private let terms: [TermGradesModel] = DataExample.getTermGradesModel()
    
    private let spreadsheetView = SpreadsheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Grades List"
        
        embedSpreadSheet()
    }
    
    private func embedSpreadSheet() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(spreadsheetView)
        spreadsheetView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().offset(-9)
            $0.bottom.equalToSuperview()
        }
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        spreadsheetView.register(ColumnIndexCell.self, forCellWithReuseIdentifier: ColumnIndexCell.className)
        spreadsheetView.register(RowValueCell.self, forCellWithReuseIdentifier: RowValueCell.className)
    }
    
    private func openSelection() {
        let vc = TermSelectionViewController()
        vc.data = terms
        vc.selectedTermModel = currentlySelectedTerm
        vc.onSelectTerm = { [weak self] model in
            self?.currentlySelectedTerm = model
        }
        
        present(vc, animated: true, completion: nil)
    }
}

extension GradesListPage: SpreadsheetViewDataSource {
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 3
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return (currentlySelectedTerm?.subjects.count ?? 0) + 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 120
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        50
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        guard indexPath.row != 0 else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: ColumnIndexCell.className, for: indexPath) as? ColumnIndexCell
            switch indexPath.column {
            case 0:
                cell?.text = "Subject"
            case 1:
                cell?.text = "Attendace"
            case 2:
                cell?.text = "Grade"
            default:
                break
            }
            
            return cell
        }
        
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: RowValueCell.className, for: indexPath) as? RowValueCell
        
        guard let subject = currentlySelectedTerm?.subjects[indexPath.row - 1] else {
            return cell
        }
            
        switch indexPath.column {
        case 0:
            cell?.text = subject.subjectTitle
            cell?.shouldAlignToRight = false
        case 1:
            cell?.text = "0%"
            cell?.shouldAlignToRight = true
        case 2:
            cell?.text = subject.overallGrade
            cell?.shouldAlignToRight = true
        default:
            break
        }
        
        return cell
    }
}

extension GradesListPage: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        guard
            indexPath.row > 0,
            let model = currentlySelectedTerm?.subjects[indexPath.row - 1]
        else { return }
        
        let vc = GradesDetailsPage(model: model)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
