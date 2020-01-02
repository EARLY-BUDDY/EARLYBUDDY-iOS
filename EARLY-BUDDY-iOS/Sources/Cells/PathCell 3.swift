//
//  RouteCell.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/29.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

class PathCell: UITableViewCell {
    
    @IBOutlet var shortestLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var totalTransport: UILabel!
    @IBOutlet var transferCount: UILabel!
    @IBOutlet var totalWalkTime: UILabel!
    @IBOutlet var totalCost: UILabel!
    @IBOutlet var detailPathButton: UIButton!
    @IBOutlet var routeCV: UICollectionView!
    @IBOutlet var grayPathView: UIImageView!
    @IBOutlet var lineView: UIView!
    
    var totalTime = 90
    var testSet: [SelectPathViewController.Route] = [] {
        willSet {
            self.routeCV.reloadData()
        }
    }
    var ratio: [Double] = []
    var testBeforeValue: SelectPathViewController.Transport = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.totalTimeLabel.labelKern(kerningValue: -1.0)
        self.totalTransport.labelKern(kerningValue: -0.6)
        self.transferCount.labelKern(kerningValue: -0.6)
        self.totalWalkTime.labelKern(kerningValue: -0.6)
        self.totalCost.labelKern(kerningValue: -0.6)
        
        self.routeCV.dataSource = self
        self.routeCV.delegate = self
    }
    
}

extension PathCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //LineCell
        //CIrcleCell
        
        let type = testSet[indexPath.item].type
        let line = testSet[indexPath.item].line
        if testBeforeValue == .walk || testBeforeValue != .none {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircleCell", for: indexPath) as! CircleCell
            
            if testSet[indexPath.item+1].line == 9 || testSet[indexPath.item-1].line == 9 {
                cell.circle.backgroundColor = UIColor.mainblue
            } else if testSet[indexPath.item+1].line == 3 || testSet[indexPath.item-1].line == 3 {
                cell.circle.backgroundColor = UIColor.blue
            }
            
            testBeforeValue = type
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineCell", for: indexPath) as! LineCell
                        
                        if type == .bus {
                            cell.line.backgroundColor = UIColor.blue
                        } else if type == .subway {
                            if line == 9 {
                                cell.line.backgroundColor = UIColor.mainblue
                            } else if line == 3 {
                                cell.line.backgroundColor = UIColor.blue
                            }
                        } else {
                            cell.line.backgroundColor = UIColor.clear
                        }
            testBeforeValue = type
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testSet.count
    }
}
extension PathCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("****\(indexPath.item)")
        print(self.ratio[indexPath.item])
        let estimatedItemSize = CGSize(width: self.ratio[indexPath.item], height: 10.0)
        return estimatedItemSize
    }
}
