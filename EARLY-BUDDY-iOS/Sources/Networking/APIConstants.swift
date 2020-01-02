//
//  APIConstants.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation

struct APIConstants {
    static let BaseURL = "http://15.164.70.24:3456"
    
    // 경로찾기
    static let SearchPathURL = BaseURL + "/searchPath?"
    // 주소검색
    static let SearchAddressURL = BaseURL + "/searchAddress?addr="
}
