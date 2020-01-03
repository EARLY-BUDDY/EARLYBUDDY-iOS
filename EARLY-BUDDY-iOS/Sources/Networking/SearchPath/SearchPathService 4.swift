//
//  SearchPathService.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation
import Alamofire

struct SearchPathService {
    static let shared = SearchPathService()
    
    func searchPath(_ ex: Double, _ ey: Double, _ sx: Double, _ sy: Double, _ type: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let searchURL = APIConstants.SearchPathURL + "EX=" + String(ex) + "&EY=" + String(ey) + "&SX=" + String(sx) + "&SY=" + String(sy) + "&SearchPathType=" + String(type)
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(searchURL, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseData { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                print("value", value)
                                let result = try decoder.decode(SearchPathResponse.self, from: value)
                                // ResponseString에 있는 success로 분기 처리
                                // ResponseString에 있는 이름이 success
                                switch result.success {
                                case true:
                                    print("success")
                                    completion(.success(result.data!))
                                case false:
                                    completion(.requestErr)
                                }
                            }
                            catch {
                                print(error.localizedDescription)
                                print(APIConstants.SearchPathURL)
                            }
                        case 400:
                            completion(.requestErr)
                        default:
                            break
                        }
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.requestErr)
                break
            }
        }
    }
}

