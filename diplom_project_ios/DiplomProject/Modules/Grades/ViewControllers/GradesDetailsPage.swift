import Foundation
import UIKit

final class GradesDetailsPage: CommonViewController {
    
    let model: SubjectGradesModel
    
    private lazy var headerView: UIView = {
        let view = GradesHeaderView()
        view.title = model.subjectTitle
        
        return view
    }()
    
    private lazy var subjectView: UIView = {
        let view = OverallGradeView()
        view.grade = model.overallGrade
        
        return view
    }()
    
    private lazy var gradesView: UIView = {
        let view = GradesListView()
        view.parts = model.gradeParts
        
        return view
    }()
    
    init(model: SubjectGradesModel) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Grading"
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(101)
        }
        
        view.addSubview(subjectView)
        subjectView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(29)
            $0.trailing.equalToSuperview().offset(-29)
            $0.height.equalTo(36)
        }
        
        view.addSubview(gradesView)
        gradesView.snp.makeConstraints {
            $0.top.equalTo(subjectView.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(39)
            $0.trailing.equalToSuperview().offset(-39)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
}
