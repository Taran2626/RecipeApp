//
//  RecipeDetailVC.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class RecipeDetailVC: UIViewController {
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeSteps: UILabel!
    @IBOutlet weak var recipeCategory: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    // MARK: - Properties
    internal var recipe: Recipe?

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRecipeData()
    }

    private func setupRecipeData() {
        self.recipeIngredients?.text = recipe?.ingredients
        self.recipeSteps?.text = recipe?.steps
        self.recipeCategory?.text = recipe?.category
        self.title = recipe?.title
        if let image = recipe?.image {
            recipeImage?.image = UIImage(data:image)
        }
    }
    
    @IBAction func deleteRecord(_ sender: UIButton) {
        
        self.showAlert()
    }
    
    func showAlert() {
        UtilityFunctions.show(alert: StaticString.deleteTitle, message: StaticString.deleteSubTitle, buttonOk: {
            guard let objectId = self.recipe?.objectID else {return}
            CoreDataHelper.sharedInstance.delete(by: objectId) {
                CoreDataHelper.sharedInstance.save()
                self.navigationController?.popViewController(animated: true)
            }
            
        }, viewController: self, buttonTextOK: StaticString.ok, buttonTextCancel: StaticString.cancel, buttonCancel: {
            
        })
    }
}

// MARK: - Segue methods
extension RecipeDetailVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? RecipeAddVC)?.recipe = recipe
    }
}
