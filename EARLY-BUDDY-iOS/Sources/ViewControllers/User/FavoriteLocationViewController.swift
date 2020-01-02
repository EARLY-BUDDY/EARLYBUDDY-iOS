//
//  FavoriteLocationViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController, SearchFavoriteDelegate {
    
    weak var delegate: SearchFavoriteViewController!
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
    
    
    var firstText: String = "장소를 등록해 주세요."
    var secondText: String = "장소를 등록해 주세요."
    var thirdText: String = "장소를 등록해 주세요."
    //    let homeName = "icHomeSelectedBig"
    //    let etcName = "icEtcSelectedBig"
    //    let companyName = "icCompanySelectedBig"
    //    let schoolName = "icSchoolSelectedBig"
    
    @IBOutlet weak var registerButton: UIButton!
    var subView: UIView = UIView()
    
    var buttonNames: [String] = ["btnLocationPlus", "btnLocationPlus", "btnLocationPlus"]
    var localLabels: [String] = []
    var buttons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchFavoriteViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchFavoriteViewController") as! SearchFavoriteViewController
        searchFavoriteViewController.delegate = self
        let defaults = UserDefaults.standard
        defaults.set(buttonNames, forKey: "favoriteIconNames")
        setInit()
        setLabel(firstLocationLabel)
        setLabel(secondLocationLabel)
        setLabel(thirdLocationLabel)
        buttons = [firstLocationButton, secondLocationButton, thirdLocationButton]
    }
    func textData(withParameter param: String) {
        print("param  : ", param)
        localLabels = [param, secondText, thirdText]
        firstLocationLabel.text = localLabels[0]
        secondLocationLabel.text = localLabels[1]
        thirdLocationLabel.text = localLabels[2]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("232323232")
        if segue.identifier == "show" {
            print("asdfsdfasdfasdfsa")
            let viewController : SearchFavoriteViewController = segue.destination as! SearchFavoriteViewController
            viewController.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.view.subviews.contains(subView) {
            subView.removeFromSuperview()
        }
        
        localLabels = [firstText, secondText, thirdText]
        firstLocationLabel.text = localLabels[0]
        secondLocationLabel.text = localLabels[1]
        thirdLocationLabel.text = localLabels[2]
        
        let defaults = UserDefaults.standard
        let names = defaults.stringArray(forKey: "favoriteIconNames") ?? [String]()
        for index in 0 ... buttons.count - 1 {
            buttons[index].setImage(UIImage(named: names[index]), for: .normal)
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
        var selected: Int?
        subView = UIView(frame: self.view.frame)
        subView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.view.addSubview(subView)
        
        let favPop = self.storyboard?.instantiateViewController(withIdentifier: "FavoritePopUpViewController") as! FavoritePopUpViewController
        
        for index in 0 ... buttons.count - 1 {
            if sender == buttons[index] {
                selected = index
                myAlert.selectIdx = selected!
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

