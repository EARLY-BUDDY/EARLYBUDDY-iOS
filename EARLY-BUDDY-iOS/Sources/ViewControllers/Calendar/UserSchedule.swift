//
//  UserSchedule.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/04.
//  Copyright © 2020 김현지. All rights reserved.
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
