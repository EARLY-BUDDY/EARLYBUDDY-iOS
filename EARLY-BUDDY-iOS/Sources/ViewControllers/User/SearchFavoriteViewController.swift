//
//  SearchFavoriteViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class SearchFavoriteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet var startArriveLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchAddressTV: UITableView!
    
    var selectedIdx: Int?
    var resultAddr: String = ""
    var results: [SearchAddressResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let idx = selectedIdx else { return }
        searchAddressTV.delegate = self
        searchAddressTV.dataSource = self
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

        searchAddressTV.allowsSelection = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        }

    
    
    @IBAction func backAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        var names = defaults.stringArray(forKey: "favoriteNames") ?? [String]()
        names[selectedIdx ?? 0] = (startArriveLabel.text ?? "") + searchTextField.text!
        defaults.set(names, forKey: "favoriteNames")
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchFavoriteViewController {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let address = textField.text!
        SearchAddressService.shared.searchAddress(address) { data in
            switch data {
            case .success(let data):
                let addressResult = data as? [SearchAddressResponse]
                self.results = addressResult ?? []
                self.searchAddressTV.reloadData()
            case .requestErr:
                print("err")
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
    
        cell.placeName.text = gsno(results[indexPath.row].placeName)
        cell.addressName.text = gsno(results[indexPath.row].addressName)
        cell.roadAddressName.text = gsno(results[indexPath.row].roadAddressName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        print(cell.placeName?.text)
        searchTextField.text = cell.placeName?.text
        searchTextField.text = cell.addressName?.text
    }
}

