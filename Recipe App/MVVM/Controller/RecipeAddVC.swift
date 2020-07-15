//
//  RecipeAddVC.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class RecipeAddVC: BaseVC {
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeCategory: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var addRecipeBtn: UIButton!

    // MARK: - Properties
    private var imagePicker = PhotoPicker()
    private  var viewModel = RecipeAddViewModelImpementation()
    internal var recipe: Recipe?
    

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    private func setupView() {
        self.categoryArray = self.categoryArray
        self.setupPickerView()
        self.recipeCategory?.inputView = self.pickerView
        self.recipeCategory?.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()
        if (recipe != nil) {
            self.setupRecipeData()
        }
    }

    private func setupRecipeData() {
        self.recipeTitle?.text = recipe?.title
        self.recipeIngredients?.text = recipe?.ingredients
        self.recipeSteps?.text = recipe?.steps
        self.recipeCategory?.text = recipe?.category
        if let image = recipe?.image {
            self.recipeImage?.image = UIImage(data:image)
            self.addRecipeBtn.setTitle("", for: .normal)
        }
    }
    
    private func getRecipeModel() -> RecipeModel{
        return RecipeModel(recipeTitle: self.recipeTitle?.text, recipeIngredients: self.recipeIngredients?.text, recipeSteps: self.recipeSteps?.text, recipeCategory: recipeCategory?.text, recipeImage: recipeImage?.image)
    }
    
    private func popViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Setup Picker Data Source & Delegate
extension RecipeAddVC {
    
    private func setupPickerView() {
        let cateogryArray = self.categoryArray?.map({$0.name})
        pickerDataSource = PickerDataSource(items: cateogryArray, pickerView: pickerView)
        pickerDataSource?.aRowSelectedListener = {[unowned self](index) in
            let category = self.categoryArray
            self.recipeCategory?.text = category?[index].name
        }
    }
}

// MARK: - Picker Delegate
extension RecipeAddVC: PickerViewDelegate {

    func doneButtonClicked() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        let category = self.categoryArray
        self.recipeCategory?.text = category?[row].name
        self.recipeCategory?.resignFirstResponder()
    }

    func cancelButtonClicked() {
        self.recipeCategory?.text = nil
        self.recipeCategory?.resignFirstResponder()
    }
}

// MARK: - IBOutlet actions
extension RecipeAddVC{
    
    @IBAction func rightBarButtonAction(_ sender: Any) {
        //save recipe
        self.view.endEditing(true)
        if let oldRecipes = recipe {
            viewModel.update(oldReceipe: oldRecipes, updatedRecipe: self.getRecipeModel(), {[weak self] in
                self?.popViewController()
            })
        } else {
            viewModel.save(recipe: self.getRecipeModel(), {[weak self] in
                self?.popViewController()
            })
        }
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
          self.view.endEditing(true)
          imagePicker.pickerImage(type: .gallery, presentInVc: self, pickedListner: {[weak self] (image) in
                  sender.setTitle("", for: .normal)
                  self?.recipeImage?.image = image
          }) {
                  //image picker cancels
          }
      }
}

