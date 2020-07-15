//
//  UtilityFunctions.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit
import AVFoundation

class UtilityFunctions {
    
    // alert view controller
    class func show(alert title:String? , message:String?  , buttonOk: @escaping () -> () , viewController: UIViewController , buttonTextOK: String?, buttonTextCancel: String? , buttonCancel: (() -> ())?  ){
        let alertController = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonTextOK , style: UIAlertAction.Style.cancel, handler: {  (action) in
            buttonOk()
        }))
        if buttonTextCancel != nil {
            alertController.addAction(UIAlertAction(title: buttonTextCancel , style: UIAlertAction.Style.destructive, handler: {  (action) in
                buttonCancel?()
            }))
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}
