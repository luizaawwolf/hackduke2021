//
//  RecipeTableViewCell.swift
//  HackDuke2021
//
//  Created by Luiza Wolf on 10/23/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var RecipeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
