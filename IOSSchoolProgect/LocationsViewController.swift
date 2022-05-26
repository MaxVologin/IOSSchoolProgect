//
//  PlanetViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 27.04.2022.
//

import UIKit

class LocationsViewController: UIViewController {
    
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api/location"
    }
    
    let networkManager = ServiceLocator.locationsNetworkManager()
    
    var info: Info?
    var loadedLocationPages: [String]?
    var locations: [Location] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        requestNextLocations(url: Constants.baseURL)
        registerCell()
        setRefreshBarButtonItem()
    }
    
    func registerCell() {
        let nib = UINib(nibName: LocationTableViewCell.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LocationTableViewCell.className)
    }
    
    func setRefreshBarButtonItem() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshLocations))
        refreshButton.tintColor = .black
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    func requestDataLocations(url: String, completion: @escaping ([Location])->()) {
        networkManager.requestDataLocations(url: url)  { [ weak self ] (locationsInfo, error) in
            if let error = error {
                AppSnackBar.showSnackBar(in: self?.view, message: error.localizedDescription)
                return
            }
            self?.info = locationsInfo?.info
            guard let locations = locationsInfo?.locations else {
                return
            }
            completion(locations)
            self?.tableView.reloadData()
        }
    }
    
    func requestNextLocations(url: String) {
        requestDataLocations(url: url) { [ weak self ] (locations) in
            self?.loadedLocationPages?.append(url)
            self?.locations.append(contentsOf: locations)
        }
    }
    
    func requestPrevLocations(url: String) {
        requestDataLocations(url: url) { [ weak self ] (locations) in
            self?.loadedLocationPages?.insert(url, at: 0)
            self?.locations.insert(contentsOf: locations, at: 0)
        }
    }
        
    @objc func refreshLocations() {
        info = nil
        locations.removeAll()
        loadedLocationPages?.removeAll()
        tableView.reloadData()
        requestNextLocations(url: Constants.baseURL)
    }
    
    func deleteLocations() {
        var deletedLocations: [IndexPath] = []
        for index in 0..<20 {
            locations.removeFirst()
            let deletedLocation = IndexPath(item: index, section: 0)
            deletedLocations.append(deletedLocation)
        }
        loadedLocationPages?.removeFirst()
        tableView.deleteRows(at: deletedLocations, with: .automatic)
    }
    
    func transitionToResidentsViewController(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let residentsViewController = storyboard.instantiateViewController(withIdentifier: ResidentsViewController.className) as? ResidentsViewController {
            residentsViewController.residents = locations[index].residents
            navigationController?.pushViewController(residentsViewController, animated: true)
        }
    }
}

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.className) as? LocationTableViewCell {
            cell.configure(location: locations[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        guard let nextPageLocation = info?.next else { return }
//        if indexPath.row+2 == locations.count {
//            requestNextLocations(url: nextPageLocation)
//        }
        
        //if indexPath.row == 2
//        if indexPath.row-2 == locations.count-60 {
//            print("check prev update")
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if locations[indexPath.row].residents.count != 0 {
            transitionToResidentsViewController(index: indexPath.row)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if locations.count >= 80 {
            deleteLocations()
        }
    }
}
