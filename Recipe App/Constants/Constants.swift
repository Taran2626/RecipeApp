//
//  Constants.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import UIKit

enum CellIdentifiers: String {
    case receipecell = "ReceipeListCell"
}

enum PhotoSourceType {
    case camera
    case gallery
}

struct StaticString {
    static let deleteTitle = "Are you sure?"
    static let deleteSubTitle = "You want to delete."
    static let ok = "Ok"
    static let cancel =  "Cancel"
}

struct SegueString {
    static let segueReceipeDetails = "SegueReceipeDetails"
    static let segueEditRecipe = "SegueEditRecipe"
}
