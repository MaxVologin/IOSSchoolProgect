//
//  ParentViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 11.05.2022.
//

import UIKit

class ParentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [SectionData] = [] {
        didSet {
            registerAll()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func registerAll() {
        // пробежаться по всем ячейкам и посмотреть есть ниб файл или нет
    }
}

extension ParentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for index in 0..<dataList.count {
            if section == index {
                return dataList[index].cells.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataList[indexPath.section].cells[indexPath.row]
    }
}

struct SectionData {
    var cells: [CellData] = []
    
}

protocol CellData {
    //что могут ячейки
    //берет таблицу и возвращает строку
}

extension CellData {
    // идентифайр
}
