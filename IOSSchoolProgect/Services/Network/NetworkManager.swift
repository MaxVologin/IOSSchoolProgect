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
        static let profileURL = "https://nanopost.evolitist.com"
        static let locationsURL = "https://rickandmortyapi.com/api/location"
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
    func login(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?) {
        performRequest(url: "\(Constants.profileURL)/api/auth/login?username=\(username)&password=\(password)",
                       method: .get,
                       onRequestCompleted: completion)
    }
}

extension NetworkManager: RegistrationNetworkManager {
    func checkUsername(username: String, completion: ((CheckUsername?, Error?) -> ())?) {
        performRequest(url: "\(Constants.profileURL)/api/auth/checkUsername?username=\(username)",
                       method: .get,
                       onRequestCompleted: completion)
    }
    
    func register(username: String, password: String, completion: ((TokenResponse?, Error?) -> ())?) {
        let parametrs: [String: String] = ["username": username,
                                           "password": password]
        performRequest(url: "\(Constants.profileURL)/api/auth/register",
                       method: .post,
                       parameters: parametrs,
                       headers: nil,
                       onRequestCompleted: completion)
    }
}

extension NetworkManager: ProfileNetworkManager {
    func profile(userId: String, completion: ((Profile?, Error?) -> ())?) {
        performRequest(url: "\(Constants.profileURL)/api/v1/profile/\(userId)",
                       method: .get,
                       parameters: nil,
                       headers: nil,
                       onRequestCompleted: completion)
    }
}

extension NetworkManager: LocationsNetworkManager {
    var locationsURL: String {
        return Constants.locationsURL
    }
    
    func requestDataLocations(url: String, completion:((LocationsInfo?, Error?) -> ())?) {
        performRequest(url: url,
                       method: .get,
                       onRequestCompleted: completion)
    }
}
