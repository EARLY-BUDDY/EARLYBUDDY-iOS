//
//  SearchLargePopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class SearchLargePopUpViewController: UIViewController {

    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var sorryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmButton.layer.cornerRadius = 25
        homeButton.layer.borderWidth = 1
        homeButton.layer.borderColor = UIColor.mainblue.cgColor
        homeButton.layer.cornerRadius = 25
        
        sorryLabel.text = "해당 시간에는 막차 뿐이에요!\n그래도 등록하시겠어요?"
        sorryLabel.labelKern(kerningValue: -0.9)
    }
    


}
