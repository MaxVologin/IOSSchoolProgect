//
//  CollectionViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 22.04.2022.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // загрузку картинки выполнять в глобал канкарент
//        штука в сервисе где есть сколько то ограниченно картинок например 50
//        сервис умеет общаться с нетворк и хранить картинки
//        если есть картинка по урле то обращаться в нетворк не надо
//        хранить картнку допустим в дикшинари
//        обращение к сервису идет при формировании ячеек
//        прям в таблице сказать что хочу картинку
//        и это про список персонажей
//        в ячейке можно создать айди и сделать ее как урлу этой картинки
//        и смотреть совпадает или нет
        
//        DispatchQueue.global(qos: .default).async {
//            нетворк манаджер дай картинку
//
//            диспатчкьюмейн асинк прям внутри {
//                имаге = имаге
//            }
//        }
//        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PLCollectionViewCell.self, forCellWithReuseIdentifier: PLCollectionViewCell.className)
        let nib = UINib(nibName: TestCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TestCollectionViewCell.className)

    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item: \(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWight = UIScreen.main.bounds.width
        let sideSize = screenWight/2
        return .init(width: sideSize, height: sideSize)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
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
