//
//  ShowPathDetailViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/30.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class ShowPathDetailViewController: UIViewController {
    
    @IBOutlet var detailPathTV: UITableView!
    
    var items: [DetailPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
        
        let dummy1 = DetailPath(stations: ["외대앞", "신이문", "회기", "청량리"], type: .bus, startStation: "테크노마트앞.강변역", startNum: 2224, arriveStation: "강변역", stationNum: 1, time: 3, open: false)
        items.append(dummy1)
        
        detailPathTV.delegate = self
        detailPathTV.dataSource = self
        detailPathTV.separatorStyle = .none
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

extension ShowPathDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items[section].open == true {
            return 2 + 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        } else if indexPath.row == 1 && items[indexPath.section].open == false {
            return 80
        } else if indexPath.row == 1 && items[indexPath.section].open == true {
            return 40
        } else if indexPath.row == 2 && items[indexPath.section].open == false {
            return 40
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClickCell", for: indexPath) as! ClickCell
            
            cell.timeLabel.text = "약 \(items[indexPath.section].time)분"
            cell.transportNumLabel.text = "\(items[indexPath.section].startNum)"
            cell.stationNum.text = "\(items[indexPath.section].stationNum)개 정류장"
            cell.stationName.text = items[indexPath.section].startStation
            
            return cell
        } else if indexPath.row == 1 && items[indexPath.section].open == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArriveCell", for: indexPath) as! ArriveCell
            
            cell.arriveStationLabel.text = items[indexPath.section].arriveStation
            
            return cell
        } else if indexPath.row == 1 && items[indexPath.section].open == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPathCell", for: indexPath) as! DetailPathCell
            
            cell.stationLabel.text = items[indexPath.section].stations[0]
            
            return cell
        } else if indexPath.row == 2 && items[indexPath.section].open == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPathCell", for: indexPath) as! DetailPathCell
            
            cell.stationLabel.text = items[indexPath.section].stations[0]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArriveCell", for: indexPath) as! ArriveCell
            
            cell.arriveStationLabel.text = items[indexPath.section].arriveStation
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ClickCell else {return}
        guard let index = tableView.indexPath(for: cell) else {return}
        
        if index.row == indexPath.row {
            if index.row == 0 {
                if items[indexPath.section].open == true {
                    items[indexPath.section].open = false
                    cell.moreInfoButton.imageView?.image = UIImage(named: "icDropboxUp")
                    
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade)
                } else {
                    items[indexPath.section].open = true
                    cell.moreInfoButton.imageView?.image = UIImage(named: "icDropboxDown")
                    let section = IndexSet.init(integer: indexPath.section)
                    tableView.reloadSections(section, with: .fade)
                }
            }
        }
    }
}

