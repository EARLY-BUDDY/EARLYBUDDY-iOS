//
//  SearchPopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class SearchPopUpViewController: UIViewController {

    @IBOutlet var homeButton: UIButton!
    @IBOutlet var sorryText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sorryText.text = "앗 어쩌죠?\n가까운 거리는 일정을 등록할 수 없어요."
        sorryText.labelKern(kerningValue: -0.9)
        homeButton.layer.cornerRadius = 25
    }

}
