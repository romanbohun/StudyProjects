//
//  TitleTableViewCell.swift
//  PlayProject
//
//  Created by Roman Bogun on 7/19/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
