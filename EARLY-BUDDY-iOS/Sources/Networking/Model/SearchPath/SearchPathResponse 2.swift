//
//  File.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation
import Alamofire

struct SearchPathResponse: Codable {
    let success: Bool
    let message: String
    let data: DataClass?
}

struct DataClass: Codable {
    let subwayCount, subwayBusCount: Int
    let path: [SearchPath]
}

struct SearchPath: Codable {
    let pathType, totalTime, totalPay, transitCount: Int
    let totalWalkTime: Int
    let subPath: [SubPath]
    let leastTotalTime, leastTransitCount, leastTotalWalkTime: Int?
}

struct SubPath: Codable {
    let trafficType, distance, sectionTime: Int
    let clicked: Bool
    let stationCount: Int?
    let lane: [Lane]?
    let startName: String?
    let startX, startY: Double?
    let endName: String?
    let endX, endY: Double?
    let startID, endID: Int?
    let passStopList: PassStopList?
    let way: String?
    let wayCode: Int?
    let door: String?
    let startExitNo: String?
    let startExitX, startExitY: Double?
    let endExitNo: String?
    let endExitX, endExitY: Double?
}

struct Lane: Codable {
    let busNo: String?
    let type, busID: Int?
    let name: String?
    let subwayCode, subwayCityCode: Int?
}

struct PassStopList: Codable {
    let stations: [Station]
}

struct Station: Codable {
    let index, stationID: Int
    let stationName, x, y: String
}


