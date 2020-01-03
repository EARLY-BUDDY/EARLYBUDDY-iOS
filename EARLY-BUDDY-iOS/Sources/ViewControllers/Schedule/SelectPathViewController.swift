//
//  SelectPathViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/28.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class SelectPathViewController: UIViewController, SendDataDelegate, SortDataDelegate {

    @IBOutlet var preferButton: UIButton!
    @IBOutlet var filteringButton: UIButton!
    @IBOutlet var routeTV: UITableView!
    @IBOutlet var preferLabel: UILabel!
    @IBOutlet var filteringLabel: UILabel!
    
    var paths: [Path] = []
    
    struct Route {
        var type: Transport
        var min: Int?
        var line: Int?
    }
    
    enum Transport {
        case walk, subway, bus, none
    }
    
    var testSet: [Route] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dummyData()
        
        self.preferLabel.text = "선호수단"
        self.filteringLabel.text = "최적 경로순"

        self.preferButton.layer.cornerRadius = 13
        self.preferButton.layer.borderWidth = 1
        self.preferButton.layer.borderColor = UIColor.lightgray.cgColor
        self.filteringButton.layer.cornerRadius = 13
        self.filteringButton.layer.borderWidth = 1
        self.filteringButton.layer.borderColor = UIColor.lightgray.cgColor
        
        self.preferLabel.font = UIFont(name: "NotoSansKR-Medium", size: 12.0)
        self.filteringLabel.font = UIFont(name: "NotoSansKR-Medium", size: 12.0)
        
        let dummy1 = Route(type: .walk, min: 13)
        let dummy2 = Route(type: .none)
        let dummy3 = Route(type: .subway, min: 31, line: 9)
        let dummy4 = Route(type: .none)
        let dummy5 = Route(type: .walk, min: 4)
        let dummy6 = Route(type: .none)
        let dummy7 = Route(type: .subway, min: 24, line: 3)
        let dummy8 = Route(type: .none)
        let dummy9 = Route(type: .walk, min: 17)
        testSet.append(dummy1)
        testSet.append(dummy2)
        testSet.append(dummy3)
        testSet.append(dummy4)
        testSet.append(dummy5)
        testSet.append(dummy6)
        testSet.append(dummy7)
        testSet.append(dummy8)
        testSet.append(dummy9)
        
        routeTV.dataSource = self
        routeTV.allowsSelection = false
        routeTV.separatorStyle = .none
        
        customNavigationBar()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
                    let viewController : PreferPopUpViewController = segue.destination as! PreferPopUpViewController
                        viewController.delegate = self
        } else if segue.identifier == "sorting" {
            let viewController: SortingPopUpViewController = segue.destination as! SortingPopUpViewController
            viewController.delegate = self
        }
    }
    
    @IBAction func preferAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "PreferPopUpViewController")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func sortingAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "SortingPopUpViewController")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func sendData(data: String) {
        preferLabel.text = data
    }
    
    func sortData(data: String) {
        filteringLabel.text = data
    }
    
    
    func timeRate(dummySet: [Route]) -> [Double] {
        //view width 318
        var ratio = [Double]()
        dummySet.forEach {
            if $0.type != .none {
                ratio.append(Double(318/90) * Double($0.min!))
            } else {
                ratio.append(10.0)
            }
        }
        print("*****\(ratio)")
        return ratio
    }
    
    func customNavigationBar() {
        self.view.layer.backgroundColor = UIColor.white.cgColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "경로 선택"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    @objc func goToDetail() {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(identifier: "SearchScheduleViewController") as? SearchScheduleViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension SelectPathViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PathCell", for: indexPath) as! PathCell
        let path = paths[indexPath.row]
        
        cell.totalTimeLabel.text = path.totalTimeLabel
        cell.totalTransport.text = path.totalTransport
        cell.transferCount.text = path.transferCount
        cell.totalWalkTime.text = path.totalWalkTime
        cell.totalCost.text = path.totalCost
        cell.testSet = testSet
        cell.ratio = timeRate(dummySet: testSet)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SelectPathViewController {
    func dummyData() {
        let p1 = Path(totalTimeLabel: "1시간 30분", totalTransport: "지하철", transferCount: "환승 2회", totalWalkTime: "도보 34분", totalCost: "1,750원")
        let p2 = Path(totalTimeLabel: "1시간 30분", totalTransport: "지하철", transferCount: "환승 2회", totalWalkTime: "도보 34분", totalCost: "1,750원")
        let p3 = Path(totalTimeLabel: "1시간 30분", totalTransport: "지하철", transferCount: "환승 2회", totalWalkTime: "도보 34분", totalCost: "1,750원")
        let p4 = Path(totalTimeLabel: "1시간 30분", totalTransport: "지하철", transferCount: "환승 2회", totalWalkTime: "도보 34분", totalCost: "1,750원")

        paths = [p1, p2, p3, p4]
    }
}
