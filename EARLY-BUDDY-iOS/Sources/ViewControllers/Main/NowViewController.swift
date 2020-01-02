//
//  NowViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/26.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class NowViewController: UIViewController {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var stationLabel: UILabel!
    @IBOutlet var timeAllocationLabel: UILabel!
    @IBOutlet var arriveLabel: UILabel!
    @IBOutlet var arriveTimeLabel: UILabel!
    @IBOutlet var showTimeLabel: UILabel!
    @IBOutlet var lastLabelFirst: UILabel!
    @IBOutlet var lastLabelSecond: UILabel!
    @IBOutlet var transportColorView: UIView!
    @IBOutlet var titleAllocationLabel: UILabel!
    @IBOutlet var tiAllocationLabel: UILabel!
    @IBOutlet var allocationLabel: UILabel!
    @IBOutlet var soonLabel: UILabel!
    @IBOutlet var remainStateLabel: UITextView!
    @IBOutlet var highlightFirstView: UIView!
    @IBOutlet var highlightSecondView: UIView!
    @IBOutlet var showPath: UIButton!
    
    var count = 3
    var img: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 곧 도착 띄우기
        //        if true {
        self.soonLabel.isHidden = true
        self.arriveTimeLabel.isHidden = false
        //        } else {
        //            self.soonLabel.isHidden = true
        //            self.arriveLabel.isHidden = false
        //        }
        
        self.highlightFirstView.isHidden = true
        self.highlightSecondView.isHidden = true
        self.remainStateLabel.isHidden = false
        
        self.transportColorView.layer.cornerRadius = 3
        
        customFontKern()
        
        
    }
    
    @IBAction func showPathAction(_ sender: UIButton) {
        if self.count == 3 {
            count -= 1
            self.remainStateLabel.text = "앞으로 남은 버스는 \n2대야! 슬슬 준비해!!"
            self.remainStateLabel.labelKern(kerningValue: -1.5)
            self.remainStateLabel.font = UIFont(name: "NotoSansKR-Medium", size: 27)
            self.img = UIImage(named: "back2")
            self.backgroundImage.image = self.img
        } else if self.count == 2 {
            count -= 1
            self.remainStateLabel.text = "앞으로 남은 버스는 \n1대야! 이제 긴장해!!"
            self.remainStateLabel.labelKern(kerningValue: -1.5)
            self.remainStateLabel.font = UIFont(name: "NotoSansKR-Bold", size: 27)
            self.img = UIImage(named: "back1")
            self.backgroundImage.image = self.img
        } else if self.count == 1 {
            count -= 1
            self.remainStateLabel.isHidden = true
            self.highlightFirstView.isHidden = false
            self.highlightSecondView.isHidden = false
            self.soonLabel.isHidden = false
            self.arriveTimeLabel.isHidden = true
            self.img = UIImage(named: "back0")
            self.backgroundImage.image = self.img
        } else if self.count == 0 {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func customFontKern() {
        self.stationLabel.labelKern(kerningValue: -0.6)
        self.timeAllocationLabel.labelKern(kerningValue: -0.6)
        self.arriveLabel.labelKern(kerningValue: -1.3)
        self.showTimeLabel.labelKern(kerningValue: -1.3)
        self.lastLabelFirst.labelKern(kerningValue: -1.5)
        self.lastLabelSecond.labelKern(kerningValue: -1.5)
        self.titleAllocationLabel.labelKern(kerningValue: -0.9)
        self.tiAllocationLabel.labelKern(kerningValue: -0.7)
        self.allocationLabel.labelKern(kerningValue: -0.7)
        self.soonLabel.labelKern(kerningValue: -2.5)
        self.remainStateLabel.labelKern(kerningValue: -1.5)
    }
    

}
