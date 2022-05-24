//
//  TabBarController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 26.04.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    enum TabBarItem: Int {
        case planet
        case profile
        
        var title: String {
            switch self {
            case .planet:
                return "Выбор планеты"
            case .profile:
                return "Профиль"
            }
        }
        
        var iconName: String {
            switch self {
            case .planet:
                return "planet"
            case .profile:
                return "contact"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let tabBarItems: [TabBarItem] = [.planet, .profile]
        viewControllers = tabBarItems.enumerated().map { (index, tabBarItem) in
            switch tabBarItem {
            case .planet:
                guard let planetViewController = storyboard?.instantiateViewController(withIdentifier: LocationsViewController.className) as? LocationsViewController else { return UIViewController() }
                planetViewController.title = tabBarItems[index].title
                planetViewController.tabBarItem.title = tabBarItems[index].title
                planetViewController.tabBarItem.image = UIImage(named: tabBarItems[index].iconName)
                return UINavigationController(rootViewController: planetViewController)
            case .profile:
                guard let profileViewController = storyboard?.instantiateViewController(withIdentifier: ProfileViewController.className) as? ProfileViewController else { return UIViewController() }
                profileViewController.tabBarItem.title = tabBarItems[index].title
                profileViewController.tabBarItem.image = UIImage(named: tabBarItems[index].iconName)
                return UINavigationController(rootViewController: profileViewController)
            }
        }
    }
}
