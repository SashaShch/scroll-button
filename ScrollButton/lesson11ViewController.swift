//
//  lesson11ViewController.swift
//  ScrollButton
//
//  Created by Рома on 12.06.2020.
//  Copyright © 2020 SashaShch. All rights reserved.
//

import UIKit

class lesson11ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(addPhotoNotificvation(_:)), name: Notification.Name(rawValue: "AddPhoto"), object: nil)
    }
    
    @objc func addPhotoNotificvation(_ notification: Notification) {
        print("User want to add photo")
    }
    
    @IBAction func addPhotoButton(_ sender: Any) {
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "AddPhoto")))
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImage.image = image
            dismiss(animated:true, completion: nil)
        }
    }
    
}
