//
//  ResponseArray.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/04.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation

struct ResponseArray<T: Codable>: Codable {
    let success: Bool?
    let message: String?
    let data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent( [T].self, forKey: .data)
    }
}
