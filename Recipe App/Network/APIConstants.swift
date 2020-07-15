//
//  APIConstants.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation

// MARK: - APIConstants
internal struct APIConstants {
    struct Basepath {
        static let Development = "http://www.recipe.com/apps"
    }
    static let getRecipe = "/recipe"
}

enum MyError: Error {
    case runtimeError(String)
}

// MARK: - Keys
enum Keys : String {
    case recipeId = "recipe_id"
}

// MARK: - Validate
enum Validate : Int {
    case failure = 0
    case success = 200
    case invalidAccessToken = 401
    case adminBlocked = 403
    case none
    
    func map(response message : String?) -> String? {
        switch self {
        case .success, .failure, .invalidAccessToken, .adminBlocked :
            return message
        default:
            return nil
        }
    }
}

struct Parameters {
    static let getRecipe : [Keys] = [.recipeId]
}

typealias OptionalDictionary = [String : Any]?
