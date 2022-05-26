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
    var locations: [Location] = []
    var loadedLocationPages: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var lastKnowContentOfsset: CGFloat = 0.0
    
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
    
    @objc func refreshLocations() {
        info = nil
        locations.removeAll()
        loadedLocationPages.removeAll()
        tableView.reloadData()
        requestNextLocations(url: Constants.baseURL)
    }
    
    func requestDataLocations(url: String, completion: @escaping ([Location], Info)->()) {
        networkManager.requestDataLocations(url: url) { [ weak self ] (locationsInfo, error) in
            if let error = error {
                AppSnackBar.showSnackBar(in: self?.view, message: error.localizedDescription)
                return
            }
            
            guard let info = locationsInfo?.info,
                let locations = locationsInfo?.locations else {
                return
            }
            self?.info = info
            completion(locations, info)
        }
    }
    
    func requestNextLocations(url: String) {
        requestDataLocations(url: url) { [ weak self ] (locations, info) in
            guard let self = self,
                  let nextPageLocations = info.next else { return }
            if self.loadedLocationPages.contains(nextPageLocations) {
                return
            } else {
                self.loadedLocationPages.append(url)
                self.locations.append(contentsOf: locations)
                self.tableView.reloadData()
            }
        }
    }
    
    func requestPrevLocations(url: String) {
        requestDataLocations(url: url) { [ weak self ] (locations, info) in
            self?.loadedLocationPages.insert(url, at: 0)
            self?.locations.insert(contentsOf: locations, at: 0)
        }
    }

    func deleteFirstLocations() {
        var deletedLocations: [IndexPath] = []
        for index in 0..<20 {
            locations.removeFirst()
            let deletedLocation = IndexPath(item: index, section: 0)
            deletedLocations.append(deletedLocation)
        }
        loadedLocationPages.removeFirst()
        tableView.deleteRows(at: deletedLocations, with: .automatic)
    }
    
    func deleteLastLocations() {
        var deletedLocations: [IndexPath] = []
        for index in 60..<80 {
            locations.removeLast()
            let deletedLocation = IndexPath(item: index, section: 0)
            deletedLocations.append(deletedLocation)
        }
        loadedLocationPages.removeLast()
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
        guard let nextPageLocation = info?.next else { return }
        if indexPath.row+2 == locations.count {
            requestNextLocations(url: nextPageLocation)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if locations[indexPath.row].residents.count != 0 {
            transitionToResidentsViewController(index: indexPath.row)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let contentOffset = scrollView.contentOffset.y
            if (contentOffset > self.lastKnowContentOfsset) {
                if locations.count == 80 {
                    deleteFirstLocations()
                }
            } else {
                if locations.count == 80 {
                    deleteLastLocations()
                }
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            self.lastKnowContentOfsset = scrollView.contentOffset.y
        }
    }
}
