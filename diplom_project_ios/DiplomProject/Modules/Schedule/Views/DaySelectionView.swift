import Foundation
import UIKit

final class DaySelectionView: CommonView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    var onSelection: ((String) -> Void)?
    
    private lazy var daysLabels: [UILabel] = {
        Days.allCases.map {
            getDayLabel($0.rawValue)
        }
    }()
    
    var previousSelectedIndex: Int?
    
    override func addElements() {
        backgroundColor = .clear
        
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        daysLabels.forEach {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(dayTapped(_:)))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(recognizer)
            
            stackView.addArrangedSubview($0)
        }
    }
    
    func getDayLabel(_ dayText: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = dayText
        
        return label
    }
    
    @objc
    private func dayTapped(_ gesture: UITapGestureRecognizer) {
        guard
            let label = gesture.view as? UILabel,
            let index = daysLabels.firstIndex(of: label),
            index != previousSelectedIndex
        else { return }
        
        updateSelectedDay(index: index)
        onSelection?(daysLabels[index].text ?? "")
    }
    
    private func updateSelectedDay(index: Int) {
        if let previous = previousSelectedIndex {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0,
                options: .curveEaseInOut, animations: { [weak self] in
                    self?.daysLabels[previous].font = .systemFont(ofSize: 15, weight: .bold)
            }, completion: nil)
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0,
            options: .curveEaseInOut, animations: { [weak self] in
                self?.daysLabels[index].font = .systemFont(ofSize: 20, weight: .bold)
        }, completion: { [weak self] _ in
            self?.previousSelectedIndex = index
        })
    }
}

extension DaySelectionView {
    
    enum Days: String, CaseIterable {
        case monday = "MON"
        case tuesday = "TUE"
        case wednesday = "WED"
        case thursday = "THU"
        case friday = "FRI"
        case saturday = "SAT"
    }
}
