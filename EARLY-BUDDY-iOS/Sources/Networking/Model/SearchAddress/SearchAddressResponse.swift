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
    var placeName: String?
    var addressName: String?
    var roadAddressName: String?
    let x: String?
    let y: String?
    
    enum CodingKeys: String, CodingKey {
        case placeName = "placeName"
        case addressName = "addressName"
        case roadAddressName = "roadAddressName"
        case x = "x"
        case y = "y"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        placeName = try values.decodeIfPresent(String.self, forKey: .placeName)
        addressName = try values.decodeIfPresent(String.self, forKey: .addressName)
        roadAddressName = try values.decodeIfPresent(String.self, forKey: .roadAddressName)
        x = try values.decodeIfPresent(String.self, forKey: .x)!
        y = try values.decodeIfPresent(String.self, forKey: .y)!
    }
}
