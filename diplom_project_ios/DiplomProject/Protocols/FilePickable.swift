import Foundation
import UIKit
import MobileCoreServices

protocol FilePickable: CanDisplayAlerts {

    func getPhotoAction(_ delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> UIAlertAction
    func getMediaAction(_ delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> UIAlertAction
    func getBrowseAction(_ delegate: UIDocumentPickerDelegate & UINavigationControllerDelegate,  _ documentTypes: [String]) -> UIAlertAction

}

extension FilePickable where Self: UIViewController {
    
    func getPhotoAction(_ delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> UIAlertAction {

        let photoAction = UIAlertAction(title: "Take photo", style: .default) { _ in
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = delegate
            
            self.present(vc, animated: true)
        }
        
        photoAction.setValue(#imageLiteral(resourceName: "photo"), forKey: "image")
        
        return photoAction
    }
    
    func getMediaAction(_ delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> UIAlertAction {
        let mediaAction = UIAlertAction(title: "Media library", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let vc = UIImagePickerController()

                vc.sourceType = .photoLibrary
                vc.delegate = delegate

                self.present(vc, animated: true, completion: nil)
            }
        }
        
        mediaAction.setValue(#imageLiteral(resourceName: "media-library"), forKey: "image")
        
        return mediaAction
    }
    
    func getBrowseAction(_ delegate: UIDocumentPickerDelegate & UINavigationControllerDelegate,
                         _ documentTypes: [String] = [kUTTypePDF as String,
                                                      kUTTypeImage as String,
                                                      "com.microsoft.word.doc",
                                                      "com.microsoft.word.docx"]) -> UIAlertAction {
        let browseAction = UIAlertAction(title: "Other", style: .default) { _ in
            let vc = UIDocumentPickerViewController(
                documentTypes: documentTypes,
                in: .import
            )
            
            vc.delegate = delegate

            self.present(vc, animated: true, completion: nil)
        }
        
        browseAction.setValue(#imageLiteral(resourceName: "file"), forKey: "image")
        
        return browseAction
    }
    
}
