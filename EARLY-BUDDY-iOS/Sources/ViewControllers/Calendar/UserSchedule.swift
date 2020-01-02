//
//  UserSchedule.swift
//  EARLY-BUDDY-iOS
//
//  Created by 황효진 on 2019/12/27.
//  Copyright © 2019 김현지. All rights reserved.
//

import Foundation

class UserSchedule {
    var name : String!
    var time : String!
    var location : String!
    
    init (name : String, time : String, location : String){
        self.name = name;
        self.time = time;
        self.location = location;
    }
}
