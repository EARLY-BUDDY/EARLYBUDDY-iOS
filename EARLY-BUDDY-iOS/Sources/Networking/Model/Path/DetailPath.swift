//
//  DetailPath.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/30.
//  Copyright © 2019 김현지. All rights reserved.
//

import Foundation

struct DetailPath {

    var stations: [String] = []
    var type: Transport
    var startStation: String
    var startNum: Int
    var arriveStation: String
    var stationNum: Int
    var time: Int
    var open = false

}

enum Transport {
    case walk, subway, bus
}
