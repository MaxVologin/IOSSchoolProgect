//
//  ParentViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 11.05.2022.
//

import UIKit

class ParentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [SectionData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
//        tableView.register(ExampleTableViewCellData.self, forCellReuseIdentifier: ExampleTableViewCellData.className)
        let nib = UINib(nibName: ExampleXibTableViewCellData.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ExampleXibTableViewCellData.className)
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

class SectionData {
    var cells: [UITableViewCell] = []
    
    init(cells: [UITableViewCell]) {
        self.cells = cells
    }
}
