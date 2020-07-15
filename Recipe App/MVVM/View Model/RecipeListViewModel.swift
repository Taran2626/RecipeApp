//
//  RecipeListViewModel.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol RecipeListViewModel{
    func fetchRecipes()
}

class RecipeListViewModelImplementation: RecipeListViewModel {
    var recipes : [Recipe]?
    let persistenceManager = CoreDataHelper.sharedInstance
    func fetchRecipes(){
        self.recipes = persistenceManager.fetch(Recipe.self) ?? []
    }
    
}
