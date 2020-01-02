//
//  ClickCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/30.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class ClickCell: UITableViewCell {
    
    @IBOutlet var startCircleView: UIView!
    @IBOutlet var allocationTransport: UILabel!
    @IBOutlet var transportImage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var stationNum: UILabel!
    @IBOutlet var transportColorView: UIView!
    @IBOutlet var transportNumLabel: UILabel!
    @IBOutlet var stationName: UILabel!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var moreInfoButton: UIButton!
    
    override func awakeFromNib() {
        self.startCircleView.layer.cornerRadius = 5.5
        self.transportColorView.layer.cornerRadius = 13
        self.mapButton.layer.cornerRadius = 5
        self.mapButton.layer.borderColor = UIColor.lightgray.cgColor
        self.mapButton.layer.borderWidth = 0.8
    }
    
}
