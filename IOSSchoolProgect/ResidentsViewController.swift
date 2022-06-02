//
//  ResidentsViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 24.05.2022.
//

import UIKit

class ResidentsViewController: UIViewController {

    let networkManager = ServiceLocator.residentNetworkManager()
    let imageService = ServiceLocator.imageService()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var urlResidents: [String] = []
    var residents: [Resident] = []
    let updateResidentsQueue = DispatchQueue(label: "ResidentsRequestQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        registerCell()
        collectionView.collectionViewLayout = layout()
    }
    
    func registerCell() {
        let nib = UINib(nibName: ResidentCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ResidentCollectionViewCell.className)
    }
    
    func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: provider())
    }
    
    func provider() -> UICollectionViewCompositionalLayoutSectionProvider {
        { int, enviroment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(187))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(187))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 2)
            group.interItemSpacing = .fixed(20)
            let section = NSCollectionLayoutSection(group: group)
            let spacing: CGFloat = 24
            section.contentInsets = .init(top: spacing,
                                          leading: spacing,
                                          bottom: spacing,
                                          trailing: spacing)
            section.interGroupSpacing = 28
            return section
        }
    }
    
    func requestResident(index: Int, completion: @escaping (Resident) -> ()) {
        if residents.indices.contains(index) {
            completion(residents[index])
        } else {
            DispatchQueue.global().async {
                self.networkManager.requestResident(url: self.urlResidents[index]) { [ weak self ] (resident, error) in
                    if let error = error {
                        AppSnackBar.showSnackBar(in: self?.view, message: "Не удалось загрузить персонажа: \"\(error.localizedDescription)\"")
                    }
                    guard let resident = resident else { return }
                    self?.updateResidentsQueue.async {
                        self?.residents.append(resident)
                        completion(resident)
                    }
                }
            }
        }
    }
}

extension ResidentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urlResidents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResidentCollectionViewCell.className, for: indexPath) as? ResidentCollectionViewCell {
            cell.startCell()
            cell.id = urlResidents[indexPath.row]
            requestResident(index: indexPath.row) { [ weak self ] resident in
                guard let self = self else {
                    return
                }
                cell.imageId = resident.image
                DispatchQueue.main.async {
                    if cell.id == self.urlResidents[indexPath.row] {
                        cell.configure(resident: resident)
                    }
                }
                self.imageService.getImage(urlString: resident.image) { (image) in
                    if cell.imageId == resident.image {
                        DispatchQueue.main.async {
                            cell.setImage(image: image)
                        }
                    }
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
