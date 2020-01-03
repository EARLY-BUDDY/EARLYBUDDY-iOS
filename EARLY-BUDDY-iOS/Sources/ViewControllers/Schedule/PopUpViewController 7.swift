//
//  PopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/27.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var completeLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.completeLabel.labelKern(kerningValue: -1.2)
        
        self.homeButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
    }
    
    @objc func goToHome() {
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NoneViewController") as? NoneViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // 일정 상세보기로 가는 함수 만들기
    

}
