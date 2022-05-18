//
//  NetwirkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 15.05.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private struct Constants {
        static let baseURL = "https://nanopost.evolitist.com"
    }
    
    func performRequest<ResponseType: Decodable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers:HTTPHeaders? = nil,
        onRequestCompleted: ((ResponseType?, Error?) -> ())?
    ){
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .responseData { (afDataResponse) in
                
                guard let data = afDataResponse.data,
                      afDataResponse.error == nil
                else {
                    onRequestCompleted?(nil, afDataResponse.error)
                    return
                }
                
                do {
                    let decodedValue: ResponseType = try JSONDecoder().decode(ResponseType.self, from: data)
                    onRequestCompleted?(decodedValue, nil)
                }
                catch (let error) {
                    print("Response parsing error: \(error.localizedDescription)")
                    onRequestCompleted?(nil, error)
                }
            }
    }
}

extension NetworkManager: AuthorizationNetworkManager {
    func login(username: String?, password: String?, completion:((TokenResponse?, Error?) -> ())?) {
        guard let username = username,
              let password = password else { return }
        performRequest(url: "\(Constants.baseURL)/api/auth/login?username=\(username)&password=\(password)",
                       method: .get,
                       onRequestCompleted: completion)
    }
}

extension NetworkManager: RegistrationNetworkManager {
    func checkUsername(username: String?, completion: ((CheckUsername?, Error?) -> ())?) {
        guard let username = username else { return }
        performRequest(url: "\(Constants.baseURL)/api/auth/checkUsername?username=\(username)",
                       method: .get,
                       onRequestCompleted: completion)
    }
    
    func register(username: String?, password: String?, completion:((TokenResponse?, Error?) -> ())?) {
        guard let username = username,
              let password = password else { return }
        let parametrs: [String: String] = ["username": username,
                                           "password": password]
        performRequest(url: "\(Constants.baseURL)/api/auth/register",
                       method: .post,
                       parameters: parametrs,
                       headers: nil,
                       onRequestCompleted: completion)
    }
}
