//
//  SortingPopUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/31.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

protocol SortDataDelegate {
    func sortData(data: String)
}

class SortingPopUpViewController: UIViewController {

    @IBOutlet var popUpView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var routeLabel: UIButton!
    @IBOutlet var routeCheckImg: UIImageView!
    @IBOutlet var timeLabel: UIButton!
    @IBOutlet var timeCheckImg: UIImageView!
    @IBOutlet var transferLabel: UIButton!
    @IBOutlet var transferCheckImg: UIImageView!
    @IBOutlet var walkLabel: UIButton!
    @IBOutlet var walkCheckImg: UIImageView!
    @IBOutlet var confirmButton: UIButton!
    
    var delegate: SortDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popUpView.layer.cornerRadius = 10
        self.popUpView.dropShadow()
        
        self.titleLabel.labelKern(kerningValue: -1.2)
        self.confirmButton.layer.cornerRadius = 18
        
        self.routeLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.timeCheckImg.isHidden = true
        self.transferCheckImg.isHidden = true
        self.walkCheckImg.isHidden = true
    }
    
    @IBAction func routeCheckAction(_ sender: UIButton) {
        self.routeLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.timeLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.transferLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.walkLabel.setTitleColor(UIColor.lightgray, for: .normal)
        
        self.routeCheckImg.isHidden = false
        self.timeCheckImg.isHidden = true
        self.transferCheckImg.isHidden = true
        self.walkCheckImg.isHidden = true
        
    }
    
    @IBAction func timeCheckAction(_ sender: UIButton) {
        self.routeLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.timeLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.transferLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.walkLabel.setTitleColor(UIColor.lightgray, for: .normal)
        
        self.routeCheckImg.isHidden = true
        self.timeCheckImg.isHidden = false
        self.transferCheckImg.isHidden = true
        self.walkCheckImg.isHidden = true
        
    }
    
    @IBAction func transferCheckAction(_ sender: UIButton) {
        self.routeLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.timeLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.transferLabel.setTitleColor(UIColor.mainblue, for: .normal)
        self.walkLabel.setTitleColor(UIColor.lightgray, for: .normal)
        
        self.routeCheckImg.isHidden = true
        self.timeCheckImg.isHidden = true
        self.transferCheckImg.isHidden = false
        self.walkCheckImg.isHidden = true
        
    }
    
    @IBAction func walkCheckAction(_ sender: UIButton) {
        self.routeLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.timeLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.transferLabel.setTitleColor(UIColor.lightgray, for: .normal)
        self.walkLabel.setTitleColor(UIColor.mainblue, for: .normal)
        
        self.routeCheckImg.isHidden = true
        self.timeCheckImg.isHidden = true
        self.transferCheckImg.isHidden = true
        self.walkCheckImg.isHidden = false
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        if !routeCheckImg.isHidden {
            if let data = routeLabel.titleLabel?.text {
                delegate?.sortData(data: data)
                dismiss(animated: true, completion: nil)
            }
        } else if !timeCheckImg.isHidden {
            if let data = timeLabel.titleLabel?.text {
                delegate?.sortData(data: data)
                dismiss(animated: true, completion: nil)
            }
        } else if !transferCheckImg.isHidden {
            if let data = transferLabel.titleLabel?.text {
                delegate?.sortData(data: data)
                dismiss(animated: true, completion: nil)
            }
        } else {
            if let data = walkLabel.titleLabel?.text {
                delegate?.sortData(data: data)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
