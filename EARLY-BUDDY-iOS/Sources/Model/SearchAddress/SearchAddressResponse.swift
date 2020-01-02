//
//  SearchAddressResponse.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation
import Alamofire

struct SearchAddressResponse: Codable {
    let success: Bool
    let message: String
    let data: [Address]
}

struct Address: Codable {
    let placeName, addressName, roadAddressName: String
}
