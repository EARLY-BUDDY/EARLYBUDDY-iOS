//
//  LoginResponse.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let data: LoginResultData
}

struct LoginResultData: Codable {
    let jwt: String
    let userIdx: Int
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case jwt = "jwt"
        case userIdx = "userIdx"
        case userName = "userName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jwt = try values.decodeIfPresent(String.self, forKey: .jwt)!
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)!
        userName = try values.decodeIfPresent(String.self, forKey: .userName)!
    }
}
