import Foundation
import UIKit
import SpreadsheetView
import PromiseKit

final class AttendanceViewController: CommonViewController, FilePickable {
    private lazy var cameraView: UIView = {
        let view = CameraView()
        view.openCamera = { [weak self] in
            self?.showContextualMenu()
        }
        
        return view
    }()
    
    private let dateSelectionView = DateSelectionView()
    
    private let spreadsheetView = SpreadsheetView()
    
    var model = DataExample.getAttendanceModel()
    var absents: [AttendanceAbsentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateSelectionView.date = "May 2021"
        
        view.addSubview(cameraView)
        cameraView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82)
        }
        
        view.addSubview(dateSelectionView)
        dateSelectionView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        view.addSubview(spreadsheetView)
        spreadsheetView.snp.makeConstraints {
            $0.top.equalTo(dateSelectionView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        spreadsheetView.register(AttendanceIndexCell.self, forCellWithReuseIdentifier: AttendanceIndexCell.className)
        spreadsheetView.register(AttendanceNameCell.self, forCellWithReuseIdentifier: AttendanceNameCell.className)
        spreadsheetView.register(AttendanceWeekIndexCell.self, forCellWithReuseIdentifier: AttendanceWeekIndexCell.className)
        spreadsheetView.register(AttendanceValueCell.self, forCellWithReuseIdentifier: AttendanceValueCell.className)
        
    }
    
    private func showContextualMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(getPhotoAction(self))
        alertController.addAction(getMediaAction(self))
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension AttendanceViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.column > 0 && indexPath.row > 0 else {
            return
        }
        
        let name = model.names[indexPath.row - 1]
        let week = model.weeks[indexPath.column - 1]
        
        if absents.contains(where: { $0.name == name && $0.week == week }) {
            absents.removeAll(where: { $0.name == name && $0.week == week })
        } else {
            absents.append(AttendanceAbsentModel(name: name, week: week))
        }
        
        spreadsheetView.reloadData()
    }
}

extension AttendanceViewController: SpreadsheetViewDataSource {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 69
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 {
            return 194
        } else {
            return 64
        }
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        model.weeks.count + 1
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        model.names.count + 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if indexPath.row == 0 {
            if indexPath.column == 0 {
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: AttendanceIndexCell.className, for: indexPath) as? AttendanceIndexCell
                cell?.text = "Name"
                
                return cell
            }
            
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: AttendanceWeekIndexCell.className, for: indexPath) as? AttendanceWeekIndexCell
            cell?.text = model.weeks[indexPath.column - 1]
            
            return cell
        }
        
        if indexPath.column == 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: AttendanceNameCell.className, for: indexPath) as? AttendanceNameCell
            cell?.text = model.names[indexPath.row - 1]
            
            return cell
        }
        
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: AttendanceValueCell.className, for: indexPath) as? AttendanceValueCell
        
        let name = model.names[indexPath.row - 1]
        let week = model.weeks[indexPath.column - 1]
        
        cell?.isPresent = !(absents.contains(where: { $0.name == name && $0.week == week }))
        
        return cell
    }
    
}

extension AttendanceViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        if let selectedImage = info[.originalImage] as? UIImage {
            let timestamp = Int(Date().timeIntervalSince1970)
            let fileName = "img_\(timestamp).jpeg"

            if let data = selectedImage.jpegData(compressionQuality: 1) {
                LoadingLayer.shared.startAnimating()
                
                firstly {
                    after(seconds: 10)
                }.done { [weak self] in
                    self?.absents.append(AttendanceAbsentModel(name: "Robert Downey Jr", week: "Fri\n7"))
                    self?.absents.append(AttendanceAbsentModel(name: "Scarlett Johansson", week: "Fri\n7"))
                    
                    LoadingLayer.shared.stopAnimating()
                    self?.spreadsheetView.reloadData()
                }
            }
        }
    }
}
