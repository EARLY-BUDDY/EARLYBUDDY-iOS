//
//  NoneViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/24.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class NoneViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var noneTextView: UITextView!
    @IBOutlet var showViewButton: UIButton!
    @IBOutlet var showViewButton2: UIButton!
    @IBOutlet var showViewButton3: UIButton!
    @IBOutlet var calendarButton: UIButton!
    @IBOutlet var mypageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showViewButton.addTarget(self, action: #selector(goToView), for: .touchUpInside)
        showViewButton2.addTarget(self, action: #selector(goToView2), for: .touchUpInside)
        showViewButton3.addTarget(self, action: #selector(goToView3), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(goToMine), for: .touchUpInside)
        addImageButton.addTarget(self, action: #selector(goToMine), for: .touchUpInside)
        self.noneTextView.labelKern(kerningValue: -1.5)
        
        viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    @IBAction func goToCalendar(_ sender: UIButton) {
        guard let nextVC = UIStoryboard(name: "Calendar", bundle: nil).instantiateViewController(identifier: "CalendarViewController") as? CalendarViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func goMypageAction(_ sender: UIButton) {
        guard let nextVC = UIStoryboard(name: "Mypage", bundle: nil).instantiateViewController(identifier: "MypageViewController") as? MypageViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func goToMine() {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "MainScheduleViewController") as? MainScheduleViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func goToView2() {
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "BeforeViewController") as? BeforeViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func goToView3() {
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GoingViewController") as? GoingViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func goToView() {
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NowViewController") as? NowViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
