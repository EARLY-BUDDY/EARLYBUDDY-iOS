//
//  PopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/27.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var onFinished: (() -> Void)?
    
    @IBOutlet var completeLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    
    var titleText: String?
    var timeText: String?
    var alarmText: String?
    var rangeText: String?
    var confirm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.completeLabel.labelKern(kerningValue: -1.2)
        
        self.homeButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        self.checkButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    
    @objc func goToHome() {
        self.confirm = false
        self.dismiss(animated: true)
        onFinished?()
        
        //        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NoneViewController") as? NoneViewController else { return }
        //        nextVC.modalPresentationStyle = .fullScreen
        //        self.present(nextVC, animated: true, completion: nil)
    }
    
    // 일정 상세보기로 가는 함수 만들기
    
    @objc func goToDetail() {
        self.confirm = true
        print("goToDetail \(confirm)")
        self.dismiss(animated: true)
        onFinished?()
    }
    
    
    
}
