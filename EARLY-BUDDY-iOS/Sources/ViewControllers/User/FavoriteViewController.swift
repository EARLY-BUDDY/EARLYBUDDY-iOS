//
//  FavoriteViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
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
    
    @IBOutlet weak var registerButton: UIButton!
     
    var subView: UIView = UIView()
    
    var buttonNames: [String] = ["btnLocationPlus", "btnLocationPlus", "btnLocationPlus"]
    var localLabels: [String] = ["장소를 등록해 주세요.", "장소를 등록해 주세요.", "장소를 등록해 주세요."]
    var buttons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.set(buttonNames, forKey: "favoriteIconNames")
        defaults.set(localLabels, forKey: "favoriteNames")
        setInit()
        setLabel(firstLocationLabel)
        setLabel(secondLocationLabel)
        setLabel(thirdLocationLabel)
        buttons = [firstLocationButton, secondLocationButton, thirdLocationButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.view.subviews.contains(subView) {
            subView.removeFromSuperview()
        }
        
        let defaults = UserDefaults.standard
        let names = defaults.stringArray(forKey: "favoriteIconNames") ?? [String]()
        for index in 0 ... buttons.count - 1 {
            buttons[index].setImage(UIImage(named: names[index]), for: .normal)
        }
        let localLabels = defaults.stringArray(forKey: "favoriteNames") ?? [String]()
        
        firstLocationLabel.text = localLabels[0]
        secondLocationLabel.text = localLabels[1]
        thirdLocationLabel.text = localLabels[2]
        
        for text in localLabels {
            if firstLocationLabel.text != "장소를 등록해 주세요." {
                firstContainerView.setColor(.mainblue)
                firstLocationLabel.textColor = .black
                
            } else {
                firstContainerView.setColor(.lightGray)
                firstLocationLabel.textColor = .lightGray
            }
            if secondLocationLabel.text != "장소를 등록해 주세요." {
                secondContainerView.setColor(.mainblue)
                secondLocationLabel.textColor = .black
            } else {
                secondContainerView.setColor(.lightGray)
                secondLocationLabel.textColor = .lightGray
            }
            if thirdLocationLabel.text != "장소를 등록해 주세요." {
                thirdContainerView.setColor(.mainblue)
                thirdLocationLabel.textColor = .black
            } else {
                thirdContainerView.setColor(.lightGray)
                thirdLocationLabel.textColor = .lightGray
            }
        }
                     
        registerButton.isEnabled = false
        registerButton.backgroundColor = .lightGray

        for name in names {
            if name != "btnLocationPlus" {
                registerButton.isEnabled = true
                registerButton.backgroundColor = .mainblue
            }
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginEndViewController") as! LoginEndViewController
        loginVC.isSkip = false
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func skipAction(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginEndViewController") as! LoginEndViewController
        loginVC.isSkip = true
        self.navigationController?.pushViewController(loginVC, animated: true)
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
        var selected: Int?
        subView = UIView(frame: self.view.frame)
        subView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.view.addSubview(subView)
        
        let favPop = self.storyboard?.instantiateViewController(withIdentifier: "FavoritePopUpViewController") as! FavoritePopUpViewController
        
        for index in 0 ... buttons.count - 1 {
            if sender == buttons[index] {
                selected = index
                favPop.selectIdx = selected!
            }
        }
        
        favPop.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        favPop.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        favPop.onFinished = { [weak self] in
            let locationVC = self?.storyboard?.instantiateViewController(withIdentifier: "SearchFavoriteViewController") as! SearchFavoriteViewController
            locationVC.selectedIdx = selected
            self?.navigationController?.pushViewController(locationVC, animated: true)
        }
        self.present(favPop, animated: true, completion: nil)
    }
}

