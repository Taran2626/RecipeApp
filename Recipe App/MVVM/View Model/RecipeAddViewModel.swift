//
//  RecipeAddViewModel.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeAddViewModel {
    
    func save(recipe : RecipeModel?, _ completion: VoidCompletion?)
    func update(oldReceipe:Recipe, updatedRecipe :RecipeModel?,_ completion: VoidCompletion?)
        
}

class RecipeAddViewModelImpementation: RecipeAddViewModel {
  
    let persistenceManager = CoreDataHelper.sharedInstance
    func update(oldReceipe:Recipe, updatedRecipe :RecipeModel?,_ completion: VoidCompletion? = nil) {
        if updatedRecipe?.recipeTitle?.isEmpty == false || updatedRecipe?.recipeCategory?.isEmpty == false {
            self.map(recipe: oldReceipe, recipeModel: updatedRecipe)
            persistenceManager.save {
                completion?()
            }
        }
    }
    
    func save(recipe : RecipeModel?, _ completion: VoidCompletion?) {
        if recipe?.recipeTitle?.isEmpty == false || recipe?.recipeCategory?.isEmpty == false{
          self.map(recipe: persistenceManager.add(Recipe.self), recipeModel: recipe)
            persistenceManager.save {
                completion?()
            }
        }
    }
    
    func map(recipe: Recipe?, recipeModel:RecipeModel?) {
        recipe?.title = recipeModel?.recipeTitle
        recipe?.ingredients = recipeModel?.recipeIngredients
        recipe?.steps = recipeModel?.recipeSteps
        recipe?.category = recipeModel?.recipeCategory
        recipe?.image = recipeModel?.recipeImage?.pngData()
    }
    
}
