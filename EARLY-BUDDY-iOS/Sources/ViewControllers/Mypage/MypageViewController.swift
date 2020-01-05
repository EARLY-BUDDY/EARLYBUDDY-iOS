//
//  MypageViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/04.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController {

    @IBOutlet var customSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customSwitch.onTintColor = UIColor.white
        if self.customSwitch.isOn {
            self.customSwitch.thumbTintColor = UIColor.white
            self.customSwitch.onTintColor = UIColor.mainblue
        } else {
            self.customSwitch.thumbTintColor = UIColor.lightgray
            self.customSwitch.onTintColor = UIColor.white
        }
        
        customNavigationBar()
    }
    
    func customNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.rightBarButtonItem?.title = ""
    }

}
