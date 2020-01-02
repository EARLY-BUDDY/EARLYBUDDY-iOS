//
//  BeforeViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/26.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class BeforeViewController: UIViewController {

    @IBOutlet var beforeTextView: UITextView!
    @IBOutlet var beforeLabelFirst: UILabel!
    @IBOutlet var beforeLabelSecond: UILabel!
    @IBOutlet var timeNumLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.beforeTextView.labelKern(kerningValue: -2.5)
        self.beforeLabelFirst.labelKern(kerningValue: -1.3)
        self.beforeLabelSecond.labelKern(kerningValue: -1.3)
        self.titleLabel.labelKern(kerningValue: -0.9)
        self.timeLabel.labelKern(kerningValue: -0.7)
        self.locationLabel.labelKern(kerningValue: -0.7)
        self.timeNumLabel.labelKern(kerningValue: -4.35)
        
    }
    
    @IBAction func goToGoingView(_ sender: UIButton) {
        if self.count == 1 {
            count -= 1
            self.timeNumLabel.text = "20"
            self.beforeLabelSecond.text = "시간 전"
        } else if self.count == 0 {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
