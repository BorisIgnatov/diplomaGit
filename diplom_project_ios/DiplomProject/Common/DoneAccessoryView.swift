import UIKit

final class DoneAccessoryView: UIView {

    var doneButtonAction: (() -> Void)?

    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.setTitle("Done", for: [])
        button.setTitleColor(#colorLiteral(red: 0.2549019608, green: 0.2117647059, blue: 0.9450980392, alpha: 1), for: [])
        button.titleLabel?.font = .systemFont(ofSize: 17)
        return button
    }()

    convenience init() {
        self.init(frame: .zero)

        backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)

        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.7372040153, green: 0.7329173684, blue: 0.7576752305, alpha: 1)
        addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.bottom.equalToSuperview()
        }
    }

    @objc private func doneButtonTapped() {
        doneButtonAction?()
    }

}
