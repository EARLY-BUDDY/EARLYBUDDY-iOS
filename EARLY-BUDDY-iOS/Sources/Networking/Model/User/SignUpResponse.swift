//
//  SignUpResponse.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import Alamofire

struct SignUpResponse: Codable {
    let success: Bool
    let message: String
    let data: String
}
