//
//  FavoriteLocationViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class FavoriteLocationViewController: UIViewController {

    @IBOutlet var favoriteTV: UITableView!
    @IBOutlet var confimeButton: UIButton!
    
    let homeImage = UIImage(named: "icHomeSelectedSmall")
    let companyImage = UIImage(named: "icCompanySelectedSmall")
    let schoolImage = UIImage(named: "icSchoolSelectedSmall")
    let etcImage = UIImage(named: "icEtcSelectedSmall")
    let addImage = UIImage(named: "icLocationPlusSmall")
    
    var buttons: [UIButton] = []
    var labels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confimeButton.layer.cornerRadius = 25
        
        favoriteTV.delegate = self
        favoriteTV.dataSource = self

        customNavigationBar()
    }
    
    @IBAction func goBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func customNavigationBar() {
        self.view.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "자주 가는 장소"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

}

extension FavoriteLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        
        print(self.buttons.count)
        
        cell.favoriteIconImageButton.setImage(self.buttons[indexPath.row].image(for: .normal), for: .normal)
        cell.favoriteLocationLabel.text = self.labels[indexPath.row].text
        
        if indexPath.row == 0 {
            cell.favoriteNameLabel.text = "집"
        } else {
            cell.favoriteNameLabel.text = ""
        }
        
        return cell
    }
    
    
}
