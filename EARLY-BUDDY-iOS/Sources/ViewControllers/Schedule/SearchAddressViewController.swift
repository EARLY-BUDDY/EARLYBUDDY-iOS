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
    
    var startArrive: String = ""
    var resultAddr: String = ""
    var results: [Address] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startArriveLabel.text = startArrive
        
        searchTextField.delegate = self
        
        searchAddressTV.delegate = self
        searchAddressTV.dataSource = self
        
        customNavigationBar()
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
        
        return true
    }
}

extension SearchAddressViewController: UITableViewDelegate, UITableViewDataSource {
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
