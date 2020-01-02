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
    var items: [DetailPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customNavigationBar()
        
        SearchPathService.searchPathService.searchPath(127.08282465301149, 37.62072502768881, 127.03746391719882, 37.4720040276288, 0) { data in
            switch data {
                
            case .success(let data):
                let searchData = data as! DataClass
                
                UserDefaults.standard.set(searchData.subwayBusCount, forKey: "subwayBusCount")
                UserDefaults.standard.set(searchData.subwayCount, forKey: "subwayCount")
                UserDefaults.standard.set(searchData.path, forKey: "path")
                
                let searchPathData = data as! SearchPath
                
                UserDefaults.standard.set(searchPathData.pathType, forKey: "pathType")
                UserDefaults.standard.set(searchPathData.totalTime, forKey: "totalTime")
                UserDefaults.standard.set(searchPathData.totalPay, forKey: "totalPay")
                UserDefaults.standard.set(searchPathData.transitCount, forKey: "transitCount")
                UserDefaults.standard.set(searchPathData.totalWalkTime, forKey: "totalWalkTime")
//                UserDefaults.standard.set(searchPathData.leastTotalTime, forKey: "leastTotalTime")
//                UserDefaults.standard.set(searchPathData.leastTransitCount, forKey: "leastTransitCount")
//                UserDefaults.standard.set(searchPathData.leastTotalWalkTime, forKey: "leastTotalWalkTime")
                UserDefaults.standard.set(searchPathData.subPath, forKey: "subPath")
                
                let subPathData = data as! SubPath
                
                UserDefaults.standard.set(subPathData.trafficType, forKey: "trafficType")
                UserDefaults.standard.set(subPathData.distance, forKey: "distance")
                UserDefaults.standard.set(subPathData.sectionTime, forKey: "sectionTime")
                UserDefaults.standard.set(subPathData.stationCount, forKey: "stationCount")
                UserDefaults.standard.set(subPathData.lane, forKey: "lane")
                UserDefaults.standard.set(subPathData.startName, forKey: "startName")
                UserDefaults.standard.set(subPathData.endName, forKey: "endName")
                UserDefaults.standard.set(subPathData.passStopList, forKey: "passStopList")
                
                let laneData = data as! Lane
                
                UserDefaults.standard.set(laneData.busNo, forKey: "busNo")
                UserDefaults.standard.set(laneData.type, forKey: "type")
                UserDefaults.standard.set(laneData.name, forKey: "name")
                UserDefaults.standard.set(laneData.subwayCode, forKey: "subwayCode")
                
                let passStopData = data as! PassStopList
                
                UserDefaults.standard.set(passStopData.stations, forKey: "stations")
                
                let stationsData = data as! Station
                
                UserDefaults.standard.set(stationsData.index, forKey: "index")
                UserDefaults.standard.set(stationsData.stationName, forKey: "stationName")
                
                searchPathData.subPath.forEach { p in
                    if p.trafficType == 1 {
                        let min = p.sectionTime
                        _ = p.stationCount
                        let lane = p.lane
                        var code: [Int] = []
                        lane?.forEach({ sub in
                            code.append(sub.subwayCode!)
                        })
                        let startName = p.startName
                        let endName = p.endName
                        var stations: [String] = []
                        
                        p.passStopList?.stations.forEach({ s in
                            stations.append(s.stationName)
                        })
                        
                        let pathData = DetailPath(stations: stations, type: .subway, startStation: startName!, startNum: String(code[0]), arriveStation: endName!, stationNum: stations.count, time: min)
                        self.items.append(pathData)
                    } else if p.trafficType == 2 {
                        let min = p.sectionTime
                        _ = p.stationCount
                        let lane = p.lane
                        var code: [String] = []
                        lane?.forEach({ bus in
                            code.append(bus.busNo!)
                        })
                        let startName = p.startName
                        let endName = p.endName
                        var stations: [String] = []
                        
                        p.passStopList?.stations.forEach({ s in
                            stations.append(s.stationName)
                        })
                        
                        let pathData = DetailPath(stations: stations, type: .bus, startStation: startName!, startNum: code[0], arriveStation: endName!, stationNum: stations.count, time: min)
                        self.items.append(pathData)
                    } else if p.trafficType == 3 {
                        let min = p.sectionTime
                        let distance = p.distance
                        _ = p.sectionTime
                        self.distanceWalk.append(distance)
                        
                        let pathData = DetailPath(stations: [], type: .walk, startStation: "", startNum: "", arriveStation: "", stationNum: 0, time: min)
                        self.items.append(pathData)
                    }
                    print("items****************")
                    print(self.items)
                }
                
            case .requestErr:
                print("경로를 찾지 못함")
            }
        }
        
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClickCell", for: indexPath) as! ClickCell
            
            cell.timeLabel.text = "약 \(items[indexPath.section].time)분"
            cell.transportNumLabel.text = "\(items[indexPath.section].startNum)"
            cell.stationNum.text = "\(items[indexPath.section].stationNum)개 정류장"
            cell.stationName.text = items[indexPath.section].startStation
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArriveCell", for: indexPath) as! ArriveCell
            
            cell.arriveStationLabel.text = items[indexPath.section].arriveStation
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPathCell", for: indexPath) as! DetailPathCell
            
            cell.stationLabel.text = items[indexPath.section].stations[0]
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPathCell", for: indexPath) as! DetailPathCell
            
            cell.stationLabel.text = items[indexPath.section].stations[0]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArriveCell", for: indexPath) as! ArriveCell
            
            cell.arriveStationLabel.text = items[indexPath.section].arriveStation
            
            return cell
        }
    }
    
}
