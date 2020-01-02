//
//  MainScheduleViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/25.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit
import Foundation

class MainScheduleViewController: UIViewController {
    
    @IBOutlet var layerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var titleLineView: UIView!
    @IBOutlet var timeLineView: UIView!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var arriveLabel: UILabel!
    @IBOutlet var startTextLabel: UILabel!
    @IBOutlet var arriveTextLabel: UILabel!
    @IBOutlet var arriveButton: UIButton!
    @IBOutlet var routeLabel: UILabel!
    @IBOutlet var alarmLabel: UILabel!
    @IBOutlet var alarmChangeLabel: UILabel!
    @IBOutlet var alarmChangeButton: UIButton!
    @IBOutlet var rangeLabel: UILabel!
    @IBOutlet var rangeChangeLabel: UILabel!
    @IBOutlet var rangeChangeButton: UIButton!
    @IBOutlet var monButton: UIButton!
    @IBOutlet var tueButton: UIButton!
    @IBOutlet var wedButton: UIButton!
    @IBOutlet var thuButton: UIButton!
    @IBOutlet var friButton: UIButton!
    @IBOutlet var satButton: UIButton!
    @IBOutlet var sunButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var pathView: UIView!
    
    @IBOutlet var pathCV: UICollectionView!
    
    var paths: [Path] = []
    var totalTime = 90
    
    struct Route {
        var type: Transport
        var min: Int?
        var line: Int?
    }
    
    enum Transport {
        case walk, subway, bus, none
    }
    
    var testSet: [Route] = [] {
        willSet {
            self.pathCV.reloadData()
        }
    }
    
    var ratio: [Double] = []
    var testBeforeValue: Transport = .none
    
    var monFlag = false
    var tueFlag = false
    var wedFlag = false
    var thuFlag = false
    var friFlag = false
    var satFlag = false
    var sunFlag = false
    
    
    lazy var datePicker: UIDatePicker = {
        
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ko")
        picker.backgroundColor = UIColor.white
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return picker
        
    }()
    
    lazy var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd. a hh:mm"
        
        return formatter
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        titleTextField.delegate = self
        timeTextField.delegate = self
        
        timeTextField.inputView = datePicker
        
        customNavigationBar()
        
        // Custom UIView Layer
        self.layerView.layer.cornerRadius = 10
        
        
        // Custom TextField
        self.titleTextField.labelKern(kerningValue: -0.8)
        self.timeTextField.text = showPrint()
        
        // Button Event
        self.startButton.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        self.arriveButton.addTarget(self, action: #selector(goToSearchPath), for: .touchUpInside)
        
        self.alarmChangeButton.isHidden = true
        self.rangeChangeButton.isHidden = true
        
        self.registerButton.layer.cornerRadius = 25
        self.view.layer.backgroundColor = UIColor.mainblue.cgColor
        
        self.pathView.layer.cornerRadius = 5
        
        let dummy1 = Route(type: .walk, min: 13)
        let dummy2 = Route(type: .none)
        let dummy3 = Route(type: .subway, min: 31, line: 9)
        let dummy4 = Route(type: .none)
        let dummy5 = Route(type: .walk, min: 4)
        let dummy6 = Route(type: .none)
        let dummy7 = Route(type: .subway, min: 24, line: 3)
        let dummy8 = Route(type: .none)
        let dummy9 = Route(type: .walk, min: 18)
        testSet.append(dummy1)
        testSet.append(dummy2)
        testSet.append(dummy3)
        testSet.append(dummy4)
        testSet.append(dummy5)
        testSet.append(dummy6)
        testSet.append(dummy7)
        testSet.append(dummy8)
        testSet.append(dummy9)
        
        self.ratio = timeRate(dummySet: testSet)
        
        self.pathCV.delegate = self
        self.pathCV.dataSource = self
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "일정 등록"
    }
    
    @IBAction func alarmAction(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "알림", preferredStyle: .actionSheet)
        
        let fiveMinute = UIAlertAction(title: "배차 5분 전", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.alarmChangeButton.isHidden = false
            self.alarmChangeLabel.text = "배차 5분 전"
            self.alarmChangeLabel.textColor = UIColor.black
        }
        let tenMinute = UIAlertAction(title: "배차 10분 전", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.alarmChangeButton.isHidden = false
            self.alarmChangeLabel.text = "배차 10분 전"
            self.alarmChangeLabel.textColor = UIColor.black
        }
        let twentyMinute = UIAlertAction(title: "배차 20분 전", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.alarmChangeButton.isHidden = false
            self.alarmChangeLabel.text = "배차 20분 전"
            self.alarmChangeLabel.textColor = UIColor.black
        }
        let noMinute = UIAlertAction(title: "알림 없음", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.alarmChangeButton.isHidden = false
            self.alarmChangeLabel.text = "알림 없음"
            self.alarmChangeLabel.textColor = UIColor.black
        }
        
        fiveMinute.setValue(UIColor.mainblue, forKey: "titleTextColor")
        tenMinute.setValue(UIColor.mainblue, forKey: "titleTextColor")
        twentyMinute.setValue(UIColor.mainblue, forKey: "titleTextColor")
        noMinute.setValue(UIColor.lightGray, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.setValue(UIColor.mainblue, forKey: "titleTextColor")
        
        optionMenu.addAction(fiveMinute)
        optionMenu.addAction(tenMinute)
        optionMenu.addAction(twentyMinute)
        optionMenu.addAction(noMinute)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func rangeAction(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "배차 알림 개수", preferredStyle: .actionSheet)
        
        let one = UIAlertAction(title: "1대 전 배차부터", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.rangeChangeButton.isHidden = false
            self.rangeChangeLabel.text = "1대 전 배차부터"
            self.rangeChangeLabel.textColor = UIColor.black
        }
        let two = UIAlertAction(title: "2대 전 배차부터", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.rangeChangeButton.isHidden = false
            self.rangeChangeLabel.text = "2대 전 배차부터"
            self.rangeChangeLabel.textColor = UIColor.black
        }
        let three = UIAlertAction(title: "3대 전 배차부터", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.rangeChangeButton.isHidden = false
            self.rangeChangeLabel.text = "3대 전 배차부터"
            self.rangeChangeLabel.textColor = UIColor.black
        }
        let last = UIAlertAction(title: "마지막 배차만", style: .default){
            (Action) -> Void in
            sender.isHidden = true
            self.rangeChangeButton.isHidden = false
            self.rangeChangeLabel.text = "마지막 배차만"
            self.rangeChangeLabel.textColor = UIColor.black
        }
        
        one.setValue(UIColor.mainblue, forKey: "titleTextColor")
        two.setValue(UIColor.mainblue, forKey: "titleTextColor")
        three.setValue(UIColor.mainblue, forKey: "titleTextColor")
        last.setValue(UIColor.mainblue, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.setValue(UIColor.mainblue, forKey: "titleTextColor")
        
        optionMenu.addAction(one)
        optionMenu.addAction(two)
        optionMenu.addAction(three)
        optionMenu.addAction(last)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func pickWeek(_ sender: UIButton) {
        if sender.isTouchInside {
            if sender == self.monButton {
                if self.monFlag == false {
                    self.monFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.monFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            } else if sender == self.tueButton {
                if self.tueFlag == false {
                    self.tueFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.tueFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            } else if sender == self.wedButton {
                if self.wedFlag == false {
                    self.wedFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.wedFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            } else if sender == self.thuButton {
                if self.thuFlag == false {
                    self.thuFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.thuFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            } else if sender == self.friButton {
                if self.friFlag == false {
                    self.friFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.friFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            } else if sender == self.satButton {
                if self.satFlag == false {
                    self.satFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.satFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            } else if sender == self.sunButton {
                if self.sunFlag == false {
                    self.sunFlag = true
                    sender.layer.backgroundColor = UIColor.mainblue.cgColor
                    sender.setTitleColor(UIColor.white, for: .normal)
                    sender.layer.borderWidth = 0
                } else {
                    self.sunFlag = false
                    sender.layer.backgroundColor = UIColor.white.cgColor
                    sender.setTitleColor(UIColor.lightgray, for: .normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.lightgray.cgColor
                }
            }
        }
    }
    
    @IBAction func showConfirmAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        myAlert.onFinished = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func timeRate(dummySet: [Route]) -> [Double] {
        //view width 274
        var ratio = [Double]()
        dummySet.forEach {
            if $0.type != .none {
                ratio.append(Double(274/90) * Double($0.min!) - 10.0)
            } else {
                ratio.append(10.0)
            }
        }
        print("*****\(ratio)")
        return ratio
    }
    
    func showPrint() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd. a hh:mm"
        let currentDateString = formatter.string(from: Date())
        
        return currentDateString
    }
    
    func customNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "일정 등록"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func customText() {
        self.titleTextField.labelKern(kerningValue: -0.8)
        self.timeTextField.labelKern(kerningValue: -0.8)
        self.startTextLabel.labelKern(kerningValue: -0.8)
        self.arriveTextLabel.labelKern(kerningValue: -0.8)
        self.rangeChangeLabel.labelKern(kerningValue: -0.8)
        self.startLabel.labelKern(kerningValue: -0.6)
        self.arriveLabel.labelKern(kerningValue: -0.6)
    }
    
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        timeTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func goToSearch() {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "SelectPathViewController") as? SelectPathViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func goToSearchPath() {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "ShowPathDetailViewController") as? ShowPathDetailViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}

extension MainScheduleViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleTextField {
            self.titleLineView.backgroundColor = UIColor.mainblue
            self.titleLineView.translatesAutoresizingMaskIntoConstraints = false
            self.titleLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
        else if textField == timeTextField {
            self.timeLineView.backgroundColor = UIColor.mainblue
            self.timeLineView.translatesAutoresizingMaskIntoConstraints = false
            self.timeLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            self.titleLineView.backgroundColor = UIColor.darkgray
            self.titleLineView.translatesAutoresizingMaskIntoConstraints = false
            self.titleLineView.heightAnchor.constraint(equalToConstant: 0.33).isActive = true
        }
        else if textField == timeTextField {
            self.timeLineView.backgroundColor = UIColor.darkgray
            self.timeLineView.translatesAutoresizingMaskIntoConstraints = false
            self.timeLineView.heightAnchor.constraint(equalToConstant: 0.33).isActive = true
        }
    }
}

extension MainScheduleViewController: UICollectionViewDataSource {
    
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
extension MainScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("****\(indexPath.item)")
        print(self.ratio[indexPath.item])
        let estimatedItemSize = CGSize(width: self.ratio[indexPath.item], height: 10.0)
        return estimatedItemSize
    }
}

