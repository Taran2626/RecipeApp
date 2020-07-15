//
//  Router.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit

protocol Router {
    var route : String { get }
    var parameters : OptionalDictionary { get }
    func handle(data : Data) -> Any?
    var method : HTTPMethod { get }
}

// this extension is used to club value with keys and return dictionary
extension Sequence where Iterator.Element == Keys {
    
    func map(values: [Any?]) -> OptionalDictionary {
        var params = [String : Any]()
        for (index,element) in zip(self,values) {
            params[index.rawValue] = element
        }
        return params
    }
}

enum APIEndpoint {
    case getRecipe(RecipeId: String?)
}

enum HTTPMethod : String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

extension APIEndpoint : Router {
    
    var route : String  {
        switch self {
        case .getRecipe(_): return APIConstants.getRecipe
        }
    }
    
    var parameters: OptionalDictionary{
        return format()
    }
    
    
    func format() -> OptionalDictionary {
        
        switch self {
        case .getRecipe(let recipeId) :
            return Parameters.getRecipe.map(values: [recipeId])
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .getRecipe(_): return .post
        }
    }
}
