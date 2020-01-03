//
//  AddressCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    
    @IBOutlet var placeName: UILabel!
    @IBOutlet var addressName: UILabel!
    @IBOutlet var roadNameView: UIView!
    @IBOutlet var roadAddressName: UILabel!
    
    override func awakeFromNib() {
        self.roadNameView.layer.cornerRadius = 10
        self.roadNameView.layer.borderWidth = 1
        self.roadNameView.layer.borderColor = UIColor.darkgray.cgColor
    }
    
}
