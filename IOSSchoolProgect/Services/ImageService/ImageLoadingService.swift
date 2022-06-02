//
//  ImageLoadingService.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 31.05.2022.
//

import UIKit

protocol ImageLoadingService {
    func getImage(urlString: String, completion: @escaping (UIImage?) -> ())
}
