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
    
    var distanceWalk: [Int] = []
    //    var searchPath: SearchPath?
    var paths: [SearchPath] = []
    //    var subPaths: [SubPath] = []
    var subPaths: [ Int : [SubPath] ] = [:]
    
    let startPlace = "출발입니당"
    let endPlace = "도착입니당 배고프네요"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
        
        SearchPathService.shared.searchPath(127.08282465301149, 37.62072502768881, 127.03746391719882, 37.4720040276288, 0) { data in
            switch data {
            case .success(let result):
                print("success")
                let searchPathResult = result as? SearchPathResponse
                self.paths = searchPathResult?.data?.path ?? []
                for index in 0 ... self.paths.count {
                    self.subPaths[index] = self.paths[index].subPath
                    print("subPaths  : ", self.subPaths)
                }
            case .requestErr:
                print("requestErr")
            }
        }
        
        //        if let searchPath = searchPath {
        //            self.subPaths = searchPath.subPath
        //        }
        
        //        detailPathTV.delegate = self
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

extension ShowPathDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subPaths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subPath = subPaths[indexPath.row]
        var previousPath: SubPath
        var nextPath: SubPath
        if indexPath.row != 0 {
            previousPath = subPaths[2]![indexPath.row - 1]
        }
        if indexPath.row != subPaths.count - 1 {
            nextPath = subPaths[2]![indexPath.row + 1]
        }
        
        
        switch subPath![2].trafficType {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClickCell", for: indexPath) as! ClickCell
            for (_, station) in subPath![2].passStopList!.stations.enumerated()  {
                let busStopView = BusStopView.instanceFromNib()
                busStopView.titleLabel.text = station.stationName
                busStopView.isHidden = true
                cell.busStopStackView.addArrangedSubview(busStopView)
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClickCell", for: indexPath) as! ClickCell
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalkCell", for: indexPath) as! WalkCell
            cell.startLocLabel.text = startPlace
            cell.walkArriveLabel.text = endPlace
            cell.distanceLabel.text = "도보 \(subPath![2].distance)m"
            cell.walkTimeLabel.text = "약 \(subPath![2].sectionTime)분"
            return cell
            
        default:
            assert(false)
        }
    }
    
}

extension ShowPathDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


