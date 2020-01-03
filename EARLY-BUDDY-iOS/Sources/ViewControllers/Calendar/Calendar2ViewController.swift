//
//  Calendar2ViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/04.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit
import FSCalendar

class Calendar2ViewController: UIViewController {

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
        self.calendar.placeholderType = .none
        self.navigationController?.navigationBar.barTintColor = .blue
        self.calendar.appearance.headerTitleFont = UIFont.init(name:"NotoSansKR-Bold",size: 18)
        self.calendar.appearance.weekdayFont = UIFont.init(name:"NotoSansKR-Bold",size: 12)
        self.calendar.appearance.titleFont = UIFont.init(name:"Roboto-Regular", size: 20)
 }
}
