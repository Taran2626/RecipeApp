//
//  PickerDataSource.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Mac-Taranjeet. All rights reserved.
//

import UIKit

typealias  DidSelectedPickerRow = (_ indexPath : Int) -> ()

//PickerDataSource
class PickerDataSource: NSObject  {
    
    var items : Array<Any>?
    var pickerView  : UIPickerView?
    var aRowSelectedListener : DidSelectedPickerRow?
    
    //init method
    init (items : Array<String>?, pickerView : UIPickerView?) {
        self.pickerView = pickerView
        self.items = items
    }
    
    override init() {
        super.init()
    }
    
}

// MARK: -Picker Data Source & Delegate
extension PickerDataSource: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return /items?.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items?[row] as? String
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let block = aRowSelectedListener{
            block(row)
        }
    }
}
