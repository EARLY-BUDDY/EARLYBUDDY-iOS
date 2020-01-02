//
//  SearchScheduleViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/27.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class SearchScheduleViewController: UIViewController {
    
    @IBOutlet var goStartButton: UIButton!
    @IBOutlet var goArriveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
    }
    
    @IBAction func goStartSearch(_ sender: UIButton) {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "SearchAddressViewController") as? SearchAddressViewController else { return }
        nextVC.startArrive = "출발 : "
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func goArriveSearch(_ sender: UIButton) {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "SearchAddressViewController") as? SearchAddressViewController else { return }
        nextVC.startArrive = "도착 : "
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func customNavigationBar() {
        self.view.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "장소 선택"
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
