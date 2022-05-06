//
//  CompositionalCollectionViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class CompositionalCollectionViewController: UIViewController {

    let networkManager = NetworkManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Это титл"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PLCollectionViewCell.self, forCellWithReuseIdentifier: PLCollectionViewCell.className)
        let nib = UINib(nibName: TestCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TestCollectionViewCell.className)
        collectionView.collectionViewLayout = layout()
        
//        networkManager.performRequest(url: <#T##String#>,
//                                      method: .get,
//                                      onRequestCompleted: <#T##((Decodable?, Error?) -> ())?##((Decodable?, Error?) -> ())?##(Decodable?, Error?) -> ()#>)
    }
    
    
    @IBAction func tapA(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        if let targetVC = storyboard.instantiateViewController(withIdentifier: AuthorizationViewController.className) as? AuthorizationViewController {
            targetVC.title = "через шоу"
            targetVC.printString(Self.className)
            navigationController?.show(targetVC, sender: nil)
        }
    }
    
    func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: provider())
    }
    
    func provider() -> UICollectionViewCompositionalLayoutSectionProvider {
        { int, enviroment in
            if int == 0 {
                let spacing: CGFloat = 10
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: 2)
                group.interItemSpacing = .fixed(spacing)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing,
                                              leading: spacing,
                                              bottom: spacing,
                                              trailing: spacing)
                section.interGroupSpacing = spacing
                return section
            }
            else {
                let spacing: CGFloat = 10
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: 2)
                group.interItemSpacing = .fixed(spacing)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: spacing,
                                              leading: spacing,
                                              bottom: spacing,
                                              trailing: spacing)
                section.interGroupSpacing = spacing
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
            
        }
    }
}

extension CompositionalCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item: \(indexPath.item)")
    }
}

extension CompositionalCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item < 5 else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.className, for: indexPath) as? TestCollectionViewCell {
                cell.title.text = "Section: \(indexPath.section)"
                cell.subTitle.text = "Item: \(indexPath.item)"
                return cell
            }
            return UICollectionViewCell()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PLCollectionViewCell.className, for: indexPath) as? PLCollectionViewCell {
            cell.customView.backgroundColor = .systemTeal
            return cell
        }
        return UICollectionViewCell()
    }
}
