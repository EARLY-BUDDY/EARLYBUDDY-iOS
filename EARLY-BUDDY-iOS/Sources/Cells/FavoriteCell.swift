//
//  FavoriteCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet var favoriteIconImageButton: UIButton!
    @IBOutlet var favoriteNameLabel: UILabel!
    @IBOutlet var favoriteLocationLabel: UILabel!
    
    override func awakeFromNib() {
        favoriteNameLabel.labelKern(kerningValue: -0.8)
        favoriteLocationLabel.labelKern(kerningValue: -0.8)
    }
    
}
