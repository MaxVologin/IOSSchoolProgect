//
//  ImageNetworkManager.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 31.05.2022.
//

import Foundation

protocol ImageNetworkManager {
    func getImage(urlString: String, competeion: ((Data?) -> ())?)
}
