//
//  BaseVC.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Mac-Taranjeet. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    // MARK: - Properties
    let pickerView = PickerView()
    var categoryArray: [Category]?

    //MARK:- dataSource
    var pickerDataSource: PickerDataSource?{
        didSet{
            self.pickerView.dataSource = pickerDataSource
            self.pickerView.delegate = pickerDataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
    }
    
    public func getCategories()  {
        if let recipeCategories =  RecipeCategories.retrieveLibrary() {
            categoryArray = recipeCategories.categories
        }
            
    }    
}
