//
//  UsersService.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//
import Alamofire

struct UsersService {
    
    private let manager = Alamofire.SessionManager.default
    
    static let usersService = UsersService()
    
    func signupNetwork(_ id: String,_ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let searchAddrURL = APIConstants.SignUpURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let parameters: Parameters = [
            "userId": id,
            "userPw": password,
        ]
        
        Alamofire.request(searchAddrURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate(contentType: ["application/json"]).responseData { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(SignUpResponse.self, from: value)
                                
                                switch result.success {
                                case true:
                                    print("Sign Up Networking Success. \n Sign Up result : ", result)
                                    completion(.success(result.data))
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
    
    func loginNetwork(_ id: String,_ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        self.manager.session.configuration.timeoutIntervalForRequest = 120
        let searchAddrURL = APIConstants.SignInURL
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let parameters: Parameters = [
            "userId": id,
            "userPw": password,
            "deviceToken": "fyG5BOMVqFM:APA91bGGIEdk21i6sgXWTRNepyf-1f4Znmv1qOMxPwuYLlsz02ux7l7SKMdYjGRYDIRVhdITjDA8ZsjNmWrB-tYwuyA-kNgP6O0SqTwTat0dXR-vygExOfpHaxSg8Xcs3OJS25B8GGXS"
        ]
        
        manager.request( searchAddrURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate(contentType: ["application/json"]).responseData { response in
            print("searchAddrURL : ", searchAddrURL)
            print("parameters : ", parameters)
            print("response : ", response)
            switch response.result {
            case .success:
                if let value = response.result.value {
                    print("value : ", value)
                    if let status = response.response?.statusCode {
                        print("status : ", status)
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(LoginResponse.self, from: value)
                                
                                switch result.success {
                                case true:
                                    print("Sign Up Networking Success. \n Sign Up result : ", result)
                                    completion(.success(result.data))
                                case false:
                                    completion(.requestErr)
                                }
                            }
                            catch {
                                print(error.localizedDescription)
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
