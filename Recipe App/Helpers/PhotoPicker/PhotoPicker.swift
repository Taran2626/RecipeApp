//
//  PhotoPicker.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class PhotoPicker: NSObject , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    typealias onPicked = (UIImage) -> ()
    typealias onCanceled = () -> ()
    
    var pickedListner : onPicked?
    var canceledListner : onCanceled?
    static let sharedInstance = PhotoPicker()
    
    override init(){
        super.init()
    }

    func pickerImage( type : PhotoSourceType , presentInVc : UIViewController , pickedListner : @escaping onPicked , canceledListner : @escaping onCanceled){
        
        self.pickedListner = pickedListner
        self.canceledListner = canceledListner
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = type == .camera ? UIImagePickerController.SourceType.camera : UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        DispatchQueue.main.async {
            presentInVc.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if let listener = canceledListner{
            listener()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage , let listener = pickedListner{
            
            listener(image)
        }
    }
}
