//
//  DetailScheduleViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/01.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController {
    
    @IBOutlet var scheduleTitleLabel: UITextField!
    @IBOutlet var scheduleTimeLabel: UITextField!
    @IBOutlet var startLocationLabel: UILabel!
    @IBOutlet var arriveLocationLabel: UILabel!
    @IBOutlet var amongAlarmLabel: UILabel!
    @IBOutlet var rangeAlarmCount: UILabel!
    @IBOutlet var layerView: UIView!
    @IBOutlet var hiddenView: UIView!
    
    
//    var titleText: String = ""
//    var timeText: String = ""
//    var startLocation: String = ""
//    var arriveLocation: String = ""
//    var alarmText: String = ""
//    var rangeAlarmLabel: String = ""
//    var rangeText: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layerView.layer.cornerRadius = 10
        hiddenView.isHidden = true

        customNavigationBar()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
    }
    
    @objc func deleteAction() {
        
    }
    
    func customNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "일정 상세보기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"icDelete"), landscapeImagePhone: UIImage(named:"icDelete"), style: .plain, target: self, action: #selector(deleteAction))
    }

}
