//
//  CompositionalCollectionViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class CompositionalCollectionViewController: UIViewController {

    let networkManager = ServiceLocator.characterNetworkManager()
    let storageManager = StorageManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tapA: UIButton!
    @IBOutlet weak var aButtontrailingConstreint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Это титл"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PLCollectionViewCell.self, forCellWithReuseIdentifier: PLCollectionViewCell.className)
        let nib = UINib(nibName: TestCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TestCollectionViewCell.className)
        collectionView.collectionViewLayout = layout()
        
        
        
//        let completion: (Character?, Error?) -> () = { character, error in
//
//            let gender = Gender(rawValue: "ololo")
//            let gender2 = Gender(rawValue: "Male")
//
//            if let error = error {
//                print(error)
//            } else {
//                print(character?.id as Any)
//                print(character?.name as Any)
//                print(character?.gender.representedValue as Any)
//                print(character?.species as Any)
//                print(character?.status.representedValue as Any)
//            }
//        }
        //        networkManager.performRequest(url: "https://rickandmortyapi.com/api/character/2", method: .get, onRequestCompleted: completion)
        networkManager.getCharacter(id: 2, completion: { character, error in
            
            if let error = error {
//                print(error)
            } else {
//                print(character?.id as Any)
//                print(character?.name as Any)
//                print(character?.gender.representedValue as Any)
//                print(character?.species as Any)
//                print(character?.status.representedValue as Any)
            }
        }
        )
        
        let oldToken = storageManager.loadFromKeychein(key: .token)
        print(oldToken as Any)
        storageManager.saveToKeychein("ololo", key: .token)
        let newToken = storageManager.loadFromKeychein(key: .token)
        print(newToken as Any)
        
    }
    
    
    @IBAction func tapA(_ sender: Any) {
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseInOut) {
            [weak self] in
            self?.tapA.layer.cornerRadius = (self?.tapA.frame.size.width ?? 0) / 2.0
            self?.aButtontrailingConstreint.constant = 100
            self?.view.setNeedsLayout()
            self?.view.layoutIfNeeded()
        } completion: { [ weak self ] _ in
            self?.aButtontrailingConstreint.constant = 16
        }

        
//        let storyboard = UIStoryboard(name: "Main",
//                                      bundle: nil)
//        if let targetVC = storyboard.instantiateViewController(withIdentifier: AuthorizationViewController.className) as? AuthorizationViewController {
//            targetVC.title = "через шоу"
//            targetVC.printString(Self.className)
//            navigationController?.show(targetVC, sender: nil)
//        }
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
