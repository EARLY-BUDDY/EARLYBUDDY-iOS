//
//  FavoritePopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoritePopUpViewController: UIViewController {
    var onFinished: (() -> Void)?
    
    let fontMedium = "NotoSansKR-Medium"
    var selectIdx : Int = 5
    
    let icHomeSelect = UIImage(named: "icHomeSelected")!
    let icHomeUnSelect  = UIImage(named: "icHomeUnselected")!
    let icCompanySelected = UIImage(named: "icCompanySelected")!
    let icCompanyUnselected = UIImage(named: "icCompanyUnselected")!
    let icSchoolSelected = UIImage(named: "icSchoolSelected")!
    let icSchoolUnselected = UIImage(named: "icSchoolUnselected")!
    let icEtcSelected = UIImage(named: "icEtcSelected")!
    let icEtcUnselected = UIImage(named: "icEtcUnselected")!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var homeButton: CheckBoxButton!
    @IBOutlet weak var companyButton: CheckBoxButton!
    @IBOutlet weak var schoolButton: CheckBoxButton!
    @IBOutlet weak var etcButton: CheckBoxButton!
    
    var selectedButton: CheckBoxButton!
    var buttons: [CheckBoxButton]!
    var buttonName: [String] = ["icHomeSelectedBig", "icCompanySelectedBig", "icSchoolSelectedBig", "icEtcSelectedBig"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIcon()
        titleLabel.text = "아이콘을 선택해주세요."
        titleLabel.font = UIFont(name: fontMedium, size: 22)!
        selectButton.backgroundColor = .mainblue
        selectButton.tintColor = .white
        selectButton.titleLabel?.font = UIFont(name: fontMedium, size: 16)!
    }
    
    func setIcon(){
        homeButton.setUpImage(icHomeSelect, icHomeUnSelect)
        companyButton.setUpImage(icCompanySelected, icCompanyUnselected)
        schoolButton.setUpImage(icSchoolSelected, icSchoolUnselected)
        etcButton.setUpImage(icEtcSelected, icEtcUnselected)
        buttons = [homeButton, companyButton, schoolButton, etcButton]
        selectedButton = homeButton
        homeButton.isChecked = true
        companyButton.isChecked = false
        schoolButton.isChecked = false
        etcButton.isChecked = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        containerView.roundCorners(corners: [.allCorners], radius: 10)
        selectButton.roundCorners(corners: [.allCorners], radius: 25)
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        print(selectIdx)
        let defaults = UserDefaults.standard
        var names = defaults.stringArray(forKey: "favoriteIconNames") ?? [String]()
        for index in 0 ... buttons.count - 1 {
            print(index)
            if buttons[index] == selectedButton && selectIdx != 5 {
//                names[selectIdx] = buttonName[index]
            }
        }
//        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteLocationViewController") as! FavoriteLocationViewController
        self.dismiss(animated: true)
        onFinished?()
        
    }
    
    @IBAction func selectIconAction(_ sender: CheckBoxButton) {
        for btn in buttons {
            if ( btn == sender ){
                sender.isChecked = true
            } else {
                btn.isChecked = false
            }
        }
    }
    
}
