//
//  CalendarViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 황효진 on 2019/12/26.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var Users = [UserSchedule]();
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Users.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! CustomCell
        cell.ScheduleName.text = Users[indexPath.row].name
        cell.ScheduleTime.text = Users[indexPath.row].time
        cell.ScheduleLocation.text = Users[indexPath.row].location
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    @IBOutlet weak var calendar: FSCalendar!

    @IBAction func nextTapped(_ sender:UIButton) {
        calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
    }
    @IBAction  func previousTapped(_ sender:UIButton) {
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
    }

    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }

    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
        
        self.calendar.placeholderType = .none
        self.calendar.appearance.headerTitleFont = UIFont.init(name:"NotoSansKR-Bold",size: 18)
        self.calendar.appearance.weekdayFont = UIFont.init(name:"NotoSansKR-Bold",size: 12)
        self.calendar.appearance.titleFont = UIFont.init(name:"Roboto-Regular", size: 20)

        Users.append(UserSchedule(name: "SOPT 데모데이 -11일 데이터",time: "오후 12:20",location: "오렌지팜 서초센터"))
        Users.append(UserSchedule(name: "SOPT 데모데이 -11일 데이터",time: "오후 12:20",location: "오렌지팜 서초센터"))
        
    }

  /* 왜안댕
    func getWeekIdx(_ date: Date) -> Int{
         let tmpCalendar = Calendar(identifier: .gregorian)
         return tmpCalendar.component(.weekday, from: date)
     }
    
    
    func dayColor(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {

           let weekday = self.getWeekIdx(date)
           if weekday == 1 {
               return UIColor.red
           }
           else if weekday == 7 {
               return UIColor.blue
           }

           return nil
       }
    
 */
    
    func customNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "캘린더"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "NotoSansKR-Medium", size: 18)!, .kern: CGFloat(-0.9)]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainblue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.rightBarButtonItem?.title = ""
        let button = UIBarButtonItem(image: UIImage(named: "icPlus"), style: .plain, target: self, action: #selector(goToSchedule))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc func goToSchedule() {
        guard let nextVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "MainScheduleViewController") as? MainScheduleViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


class CustomCell : UITableViewCell {
    @IBOutlet weak var ScheduleName: UILabel!
    @IBOutlet weak var ScheduleTime: UILabel!
    @IBOutlet weak var ScheduleLocation: UILabel!
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.cornerRadius=10.0
            cardView.layer.masksToBounds = false
        
            cardView.layer.shadowColor = UIColor.gray.withAlphaComponent(1).cgColor
            
            cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
            cardView.layer.shadowOpacity = 0.5
            cardView.layer.shadowRadius = 3.0
        }
    }
}
