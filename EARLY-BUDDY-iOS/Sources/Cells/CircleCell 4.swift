//
//  CircleCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/29.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class CircleCell: UICollectionViewCell {
    
    @IBOutlet var circle: UIView!
    
    override func awakeFromNib() {
        circle.layer.cornerRadius = 5
    }
    
}
