//
//  FavoriteLocationViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController {
    var passData: (() -> String)?
    
    let fontRegular = "NotoSansKR-Regular"
    let fontMedium = "NotoSansKR-Medium"

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var firstLocationButton: UIButton!
    @IBOutlet weak var secondLocationButton: UIButton!
    @IBOutlet weak var thirdLocationButton: UIButton!
    
    @IBOutlet weak var firstLocationLabel: UILabel!
    @IBOutlet weak var secondLocationLabel: UILabel!
    @IBOutlet weak var thirdLocationLabel: UILabel!
    
    @IBOutlet weak var firstContainerView: RoundedCornerView!
    @IBOutlet weak var secondContainerView: RoundedCornerView!
    @IBOutlet weak var thirdContainerView: RoundedCornerView!

//    let homeName = "icHomeSelectedBig"
//    let etcName = "icEtcSelectedBig"
//    let companyName = "icCompanySelectedBig"
//    let schoolName = "icSchoolSelectedBig"
    
    @IBOutlet weak var registerButton: UIButton!
    
    var buttonNames: [String] = ["btnLocationPlus", "btnLocationPlus", "btnLocationPlus"]
    var buttons: [UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
        
        setLabel(firstLocationLabel)
        buttons = [firstLocationButton, secondLocationButton, thirdLocationButton]
        print("buttons : ", buttons)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(buttonNames, forKey: "favoriteIconNames")
        print("buttons : ", buttons)
        for index in 1 ... buttons.count {
            print("buttons : ", buttons)
            buttons[index].setImage(UIImage(named: buttonNames[index]), for: .normal)
        }
        
    }
    
    func setInit(){
        let imageView : UIImageView = UIImageView(image: UIImage(named: "backLocation.png")!)
        self.view.addSubview(imageView)
        titleLabel.numberOfLines = 0
        titleLabel.text = "자주 가는 장소를\n등록해주세요."
        titleLabel.font = UIFont(name: fontRegular, size: 26)!
        registerButton.backgroundColor = .lightGray
        registerButton.titleLabel?.font = UIFont(name: fontMedium, size: 18)
        registerButton.roundCorners(corners: [.allCorners], radius: 25)
        registerButton.isEnabled = false
    }
    
    func setLabel(_ label: UILabel){
        label.font = UIFont(name: fontRegular, size: 18)
        label.textColor = .lightGray
    }
    
    @IBAction func addLocationButton(_ sender: UIButton) {
        let sub = UIView(frame: self.view.frame)
        sub.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.view.addSubview(sub)

        let myAlert = self.storyboard?.instantiateViewController(withIdentifier: "FavoritePopUpViewController") as! FavoritePopUpViewController
        
        for index in 0 ... buttons.count {
            print("count@#~@#$!@#$@ : ", index)
            if sender == buttons[index] {
                myAlert.selectIdx = index
            }
        }
        
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        myAlert.onFinished = { [weak self] in
//            self?.goLoginView()
        }
        self.present(myAlert, animated: true, completion: nil)
    }
    
}
