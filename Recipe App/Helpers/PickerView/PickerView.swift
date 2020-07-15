//
//  PickerView.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import UIKit

protocol PickerViewDelegate: class {
    func doneButtonClicked()
    func cancelButtonClicked()
}

class PickerView: UIPickerView {
    
    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: PickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonClicked))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.toolbar = toolBar
    }
    
    @objc func doneButtonClicked() {
        self.toolbarDelegate?.doneButtonClicked()
    }
    
    @objc func cancelButtonClicked() {
        self.toolbarDelegate?.cancelButtonClicked()
    }
}
