//
//  SignUpCompleteViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class SignUpCompleteViewController: UIViewController {
    var onFinished: (() -> Void)?
    
    let fontMedium = "NotoSansKR-Medium"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "회원가입이 완료되었어요!"
        titleLabel.font = UIFont(name: fontMedium, size: 22)!
        goLogin.backgroundColor = .mainblue
        goLogin.tintColor = .white
        goLogin.titleLabel?.font = UIFont(name: fontMedium, size: 16)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        containerView.roundCorners(corners: [.allCorners], radius: 10)
        goLogin.roundCorners(corners: [.allCorners], radius: 25)
    }
    
    @IBAction func goLoginAction(_ sender: Any) {
        self.dismiss(animated: true)
        onFinished?()
    }
}
