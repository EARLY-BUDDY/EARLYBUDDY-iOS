//
//  DetailPathCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/30.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class DetailPathCell: UITableViewCell {
    
    @IBOutlet var stationLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var stationRoundView: UIView!
    
    override func awakeFromNib() {
        self.stationRoundView.layer.cornerRadius = 5.5
    }
    
}
