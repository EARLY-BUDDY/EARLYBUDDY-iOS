//
//  SearchAddressService.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SearchAddressService {
    static let shared = SearchAddressService()
    
    func searchAddress(_ addr: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let param: Parameters = [
            "addr" : addr
        ]
        let searchAddrURL = APIConstants.SearchAddressURL
        
        Alamofire.request(searchAddrURL, method: .get, parameters: param, encoding: URLEncoding.queryString, headers: header).responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        print(status)
                        switch status {
                        case 200:
                            do {
                                let data = response.data
                                var jsonString = JSON(data as Any).description
                                if jsonString ==  "null" {
                                    jsonString = "{}"
                                }
                                let jsonData = jsonString.data(using: .utf8) ?? Data()
                                do {
                                    let result = try JSONDecoder().decode(ResponseArray<SearchAddressResponse>.self, from: jsonData)
                                    completion(.success(result.data!))
                                    print("result. : ", result)
                                } catch let catchError{
                                    completion(.requestErr)
                                    print("캐치에러 \(catchError)")
                                }
                            }
                            catch {
                                print(error.localizedDescription)
                                print(APIConstants.SearchAddressURL)
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
