//
//  DetailScheduleViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/01.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        customNavigationBar()
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
    }

}
