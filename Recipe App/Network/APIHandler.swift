//
//  APIHandler.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation

//Api Handler
extension APIEndpoint {
    
    func handle(data : Data) -> Any? {
        switch self {
        case .getRecipe(_):
            do {
                let object = try JSONDecoder().decode([RecipeModel].self, from: data)
                return object
            }catch _ {
                return nil
            }
        }
    }
}
