//
//  ReceipeListCell.swift
//  Recipe App
//
//  Created by Taran  on 02/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class ReceipeListCell: UITableViewCell {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(recipe: Recipe?) {
        recipeTitle.text = recipe?.title
        if let image = recipe?.image {
            recipeImage.image = UIImage(data:image)
        }
        recipeImage?.clipsToBounds = true
        recipeImage?.contentMode = .scaleAspectFill
    }
    
}
