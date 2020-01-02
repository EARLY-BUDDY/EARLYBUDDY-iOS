//
//  ArriveCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/30.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class ArriveCell: UITableViewCell {
    
    @IBOutlet var arriveCircleView: UIView!
    @IBOutlet var arriveColorView: UIView!
    @IBOutlet var arriveStationLabel: UILabel!
    
    override func awakeFromNib() {
        self.arriveCircleView.layer.cornerRadius = 5.5
        self.arriveColorView.layer.cornerRadius = 13
        self.arriveColorView.layer.borderWidth = 1.5
        self.arriveColorView.layer.borderColor = UIColor(red: 51/255, green: 198/255, blue: 60/255, alpha: 1).cgColor
    }
    
}
