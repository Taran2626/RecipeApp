//
//  RecipeModel.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Mac-Taranjeet. All rights reserved.
//

import UIKit

struct RecipeModel: Decodable {
    
    var recipeTitle: String?
    var recipeIngredients: String?
    var recipeSteps: String?
    var recipeCategory: String?
    var recipeImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
       case recipeTitle
    }
}
