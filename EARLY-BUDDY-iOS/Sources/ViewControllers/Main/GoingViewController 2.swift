//
//  GoingViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/26.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class GoingViewController: UIViewController {

    @IBOutlet var goingTextView: UITextView!
    @IBOutlet var promiseLabel: UILabel!
    @IBOutlet var promiseTimeLabel: UILabel!
    @IBOutlet var detailScheduleButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customKern()
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func customKern() {
        self.goingTextView.labelKern(kerningValue: -1.5)
        self.promiseLabel.labelKern(kerningValue: -1.3)
        self.promiseTimeLabel.labelKern(kerningValue: -2.0)
        self.titleLabel.labelKern(kerningValue: -0.9)
        self.timeLabel.labelKern(kerningValue: -0.7)
        self.locationLabel.labelKern(kerningValue: -0.7)
    }
     

}
