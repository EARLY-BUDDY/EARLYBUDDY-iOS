//
//  ClickCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/30.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

protocol DownupDelegate {
    func didDownup()
}

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
    @IBOutlet var busStopStackView: UIStackView!
    
    
    var delegate: DownupDelegate?
    
    override func awakeFromNib() {
        self.startCircleView.layer.cornerRadius = 5.5
        self.transportColorView.layer.cornerRadius = 13
        self.mapButton.layer.cornerRadius = 5
        self.mapButton.layer.borderColor = UIColor.lightgray.cgColor
        self.mapButton.layer.borderWidth = 0.8
        
        moreInfoButton.addTarget(self, action: #selector(downup), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func downup() {
        toggleStackViewSubviews()
        delegate?.didDownup()
    }
    
    func toggleStackViewSubviews() {
        for (i, v) in busStopStackView.subviews.enumerated() {
            if i == 0 { continue }
            v.isHidden.toggle()
        }
    }
}
