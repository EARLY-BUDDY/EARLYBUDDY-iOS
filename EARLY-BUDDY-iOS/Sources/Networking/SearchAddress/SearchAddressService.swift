//
//  SearchAddressService.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import Foundation
import Alamofire

struct SearchAddressService {
    static let searchAddressService = SearchAddressService()
    
    func searchAddress(_ addr: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let searchAddrURL = APIConstants.SearchAddressURL + addr
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(searchAddrURL, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: header).responseData { response in
            
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
                                
                                switch result.success {
                                case true:
                                    print("Networking Success")
                                    completion(.success(result.data!))
                                case false:
                                    completion(.requestErr)
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
