//
//  SearchFavoriteViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

protocol SearchFavoriteDelegate {
    func textData(withParameter param: String)
}

class SearchFavoriteViewController: UIViewController, UITextFieldDelegate {
    var delegate: SearchFavoriteDelegate?
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet var startArriveLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchAddressTV: UITableView!
    
    var selectedIdx: Int?
    var resultAddr: String = ""
    var results: [Address] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let idx = selectedIdx else { return }
        let defaults = UserDefaults.standard
        let names = defaults.stringArray(forKey: "favoriteIconNames") ?? [String]()
        if names[idx] == "icHomeSelectedBig" {
            startArriveLabel.text = "집 :"
        } else if names[idx] == "icCompanySelectedBig" {
            startArriveLabel.text = "회사 :"
        } else if names[idx] == "icSchoolSelectedBig" {
            startArriveLabel.text = "학교 :"
        } else {
            startArriveLabel.text = "기타 :"
        }
        searchContainerView.roundCorners(corners: [.allCorners], radius: 19)
        searchTextField.delegate = self
        searchAddressTV.delegate = self
        searchAddressTV.dataSource = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.delegate?.textData(withParameter: searchTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchFavoriteViewController {

    func textFieldDidEndEditing(_ textField: UITextField) {
        let address = textField.text!
        SearchAddressService.searchAddressService.searchAddress(address) { data in
            switch data {
            case .success(let data):
                let addressResult = data as! SearchAddressResponse
                addressResult.data.forEach { r in
                    self.results.append(r)
                }
            case .requestErr:
                print("경로를 찾지 못함")
            }
        }
    }
}

extension SearchFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        
        cell.placeName.text = results[indexPath.row].placeName
        cell.addressName.text = results[indexPath.row].addressName
        cell.roadAddressName.text = results[indexPath.row].roadAddressName
        
        return cell
    }
}

