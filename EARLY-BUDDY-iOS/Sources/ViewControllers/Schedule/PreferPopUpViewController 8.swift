//
//  PreferPopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/31.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class PreferPopUpViewController: UIViewController {

    @IBOutlet var popUpView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var allLabel: UIButton!
    @IBOutlet var allCheckImg: UIImageView!
    @IBOutlet var busLabel: UIButton!
    @IBOutlet var busCheckImg: UIImageView!
    @IBOutlet var subwayLabel: UIButton!
    @IBOutlet var subwayCheckImg: UIImageView!
    @IBOutlet var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popUpView.layer.cornerRadius = 10
        self.popUpView.dropShadow()
        self.confirmButton.layer.cornerRadius = 18
        
        self.allLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.busCheckImg.isHidden = true
        self.subwayCheckImg.isHidden = true
        
        self.titleLabel.labelKern(kerningValue: -1.2)
    }
    
    @IBAction func allCheckAction(_ sender: UIButton) {
        self.allLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.busLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.subwayLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.allCheckImg.isHidden = false
        self.busCheckImg.isHidden = true
        self.subwayCheckImg.isHidden = true
    }
    
    @IBAction func busCheckAction(_ sender: UIButton) {
        self.allLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.busLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.subwayLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.allCheckImg.isHidden = true
        self.busCheckImg.isHidden = false
        self.subwayCheckImg.isHidden = true
    }
    
    @IBAction func subwayCheckAction(_ sender: UIButton) {
        self.allLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.busLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.subwayLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.allCheckImg.isHidden = true
        self.busCheckImg.isHidden = true
        self.subwayCheckImg.isHidden = false
    }
    
    
    @IBAction func confirmAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
