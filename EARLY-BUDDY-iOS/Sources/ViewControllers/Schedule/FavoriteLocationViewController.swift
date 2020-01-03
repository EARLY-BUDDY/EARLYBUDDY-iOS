//
//  FavoriteLocationViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        customNavigationBar()
    }
    
    func customNavigationBar() {
        self.view.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "자주 가는 장소"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

}
