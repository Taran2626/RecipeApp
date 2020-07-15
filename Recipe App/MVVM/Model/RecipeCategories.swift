//
//  Categories.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import XMLParsing
import UIKit

struct Category: Codable {
    var id: String
    var name: String
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

struct RecipeCategories: Codable {
    var categories: [Category]
    enum CodingKeys: String, CodingKey {
        case categories = "category"
    }
    
    static func retrieveLibrary() -> RecipeCategories? {
        let path = Bundle.main.path(forResource: "RecipeCategories", ofType: "xml")
        guard let data = NSData(contentsOfFile: path!) else { return nil } // force unwarp if xml file path not found
        let decoder = XMLDecoder()
        let categories: RecipeCategories?
        do {
            categories = try decoder.decode(RecipeCategories.self, from: data as Data)
        } catch {
            print(error)
            categories = nil
        }
        return categories
    }
}
