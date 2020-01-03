//
//  SearchAddressViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class SearchAddressViewController: UIViewController {
    
    @IBOutlet var startArriveLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchAddressTV: UITableView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var firstImgButton: UIButton!
    @IBOutlet var secondImgButton: UIButton!
    @IBOutlet var thirdImgButton: UIButton!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    
    let homeImage = UIImage(named: "icHomeSelectedSmall")
    let companyImage = UIImage(named: "icCompanySelectedSmall")
    let schoolImage = UIImage(named: "icSchoolSelectedSmall")
    let etcImage = UIImage(named: "icEtcSelectedSmall")
    let addImage = UIImage(named: "icLocationPlusSmall")
    
    var buttons: [UIButton] = []
    var labels: [UILabel] = []
    
    var startArrive: String = ""
    var resultAddr: String = ""
    var results: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startArriveLabel.text = startArrive
        self.searchView.layer.cornerRadius = 19
        
        self.buttons = [firstImgButton, secondImgButton, thirdImgButton]
        self.labels = [firstLabel, secondLabel, thirdLabel]
        
        searchTextField.delegate = self
        searchAddressTV.delegate = self
        searchAddressTV.dataSource = self
        
        customNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "장소 선택"
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        if sender == firstImgButton {
            if firstLabel.text == "자주 가는 장소 등록" {
                guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(identifier: "FavoriteLocationViewController") as? FavoriteLocationViewController else { return }
                nextVC.buttons = self.buttons
                nextVC.labels = self.labels
                nextVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if sender == secondImgButton {
            if secondLabel.text == "자주 가는 장소 등록" {
                guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(identifier: "FavoriteLocationViewController") as? FavoriteLocationViewController else { return }
                nextVC.buttons = self.buttons
                nextVC.labels = self.labels
                nextVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if sender == thirdImgButton {
            if thirdLabel.text == "자주 가는 장소 등록" {
                guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(identifier: "FavoriteLocationViewController") as? FavoriteLocationViewController else { return }
                nextVC.buttons = self.buttons
                nextVC.labels = self.labels
                nextVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    
    func customNavigationBar() {
        self.view.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "장소 선택"
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

extension SearchAddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SearchAddressService.searched.searchAddress(textField.text!) { data in
            switch data {
            case .success(let data):
                let addressResult = data as! SearchAddressResponse
                addressResult.data?.addresses.forEach { r in
                    self.results.append(r)
                    print("\(r)-----")
                }
            case .requestErr:
                print("경로를 찾지 못함")
            }
        }
        
        return true
    }
}

extension SearchAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        
        if results[indexPath.row].placeName != nil && results[indexPath.row].roadAddressName != nil {
            cell.placeName.text = results[indexPath.row].placeName
            cell.addressName.text = results[indexPath.row].addressName
            cell.roadAddressName.text = results[indexPath.row].roadAddressName
        } else if results[indexPath.row].placeName != nil && results[indexPath.row].roadAddressName == nil {
            cell.placeName.text = results[indexPath.row].placeName
            cell.addressName.text = results[indexPath.row].addressName
            cell.roadAddressName.text = ""
        } else {
            cell.placeName.text = results[indexPath.row].addressName
            cell.addressName.text = results[indexPath.row].addressName
            cell.roadAddressName.text = ""
        }
        
        return cell
    }
    
    
}
