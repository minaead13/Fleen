//
//  MessagesViewController.swift
//  Fleen
//
//  Created by Mina Eid on 23/03/2024.
//

import UIKit
import MOLH

class MessagesViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messgesTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var sentMessagesStack: UIStackView!
    @IBOutlet weak var uploadStack: UIStackView!
    
    var messagesArray = [Messages(title: "how are you", id: 1),
                         Messages(title: "I am fine", id: 2)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        self.navigationItem.title = "Messages".localized
        self.tabBarController?.tabBar.isHidden = true
        tableView.registerCell(cell: MessagesTableViewCell.self)
        sendButton.setTitle("", for: .normal)
        messgesTextField.font =  UIFont(name: "DMSans18pt-Regular", size: 14)
        messgesTextField.placeholder = "Type your message".localized
        uploadBtn.setTitle("", for: .normal)
        sentMessagesStack.semanticContentAttribute = .forceLeftToRight
        uploadStack.semanticContentAttribute = .forceLeftToRight
        checkLanguage()
    }
    
    func checkLanguage(){
        let isArabic = MOLHLanguage.currentAppleLanguage() == "ar"
        let alignment: NSTextAlignment = isArabic ? .right : .left
        
        messgesTextField.textAlignment = alignment
    }
    
    @IBAction func didTapSendButton(_ sender: Any) {
        
    }
    
    
    @IBAction func didTapUploadBtn(_ sender: Any) {
        openDocuments()
    }
    
    func openDocuments(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera  = UIAlertAction(title: "Camera".localized, style: .default , handler: { action in
            self.getPhoto(type: .camera)
        })
        
        let gallery = UIAlertAction(title: "Gallery".localized, style: .default , handler: { action in
            self.getPhoto(type: .photoLibrary)
        })
        
        let documents = UIAlertAction(title: "Documents".localized, style: .default , handler: { action in
       
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            self.present(documentPicker, animated: true)

        })
        
                
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel , handler: { action in
          
           })
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(documents)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }
    
    func getPhoto(type: UIImagePickerController.SourceType){
        let picker  = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            print("image not found")
            return
        }
//        clientImage.image = image
//        if let imageData = image.jpegData(compressionQuality: 0.50) {
//            identityPhotoStr = imageData
//            uploadPhoto(image: imageData)
//            
//        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
     
}
    
extension MessagesViewController : UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
      //  pdfUrl = sandboxFileURL
        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
      //      pdfUrl = sandboxFileURL
//            cv.setTitle("The CV has been selected successfully", for: .normal)
            print("already exist")
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
        //        pdfUrl = sandboxFileURL
                print("copied file")
            }
            catch {
                print("error: \(error)")
            }
        }
        
    }
}

extension MessagesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessagesTableViewCell.identifier, for: indexPath) as! MessagesTableViewCell
        
        let message = messagesArray[indexPath.row]
            
            if message.id == 1 {
                cell.outerView.backgroundColor = UIColor.gold
                cell.messageLabel.textColor = .white
                cell.leadingConstant.constant = 16
                cell.trailingConstant.constant = 0
            } else if message.id == 2 {
                cell.outerView.backgroundColor = UIColor.placeHolder
                cell.messageLabel.textColor = .label
                cell.leadingConstant.constant = 0
                cell.trailingConstant.constant = 16
            }
            
            cell.messageLabel.text = message.title
        
        return cell
    }
}


struct Messages {
    let title : String
    let id : Int
}
