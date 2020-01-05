//
//  DetailPathCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/04.
//  Copyright © 2020 김현지. All rights reserved.
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
