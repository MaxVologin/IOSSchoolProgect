//
//  ExampleViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 11.05.2022.
//

import UIKit

class ExampleViewController: ParentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataList = [
            SectionData(
                cells: [
                    ExampleTableViewCellData().configure(title: "123"),
                    ExampleTableViewCellData().configure(title: "456"),
                    ExampleTableViewCellData().configure(title: "6712312318"),
                    ExampleXibTableViewCellData().configure(title: "aaaaaaa",
                                                            subTitle: "000000")
                ]
            ),
            SectionData(
                cells: [
                    ExampleXibTableViewCellData().configure(title: "bbbbbbb",
                                                            subTitle: "12121212"),
                    ExampleXibTableViewCellData().configure(title: "ccccccc",
                                                            subTitle: "3434343")
                ]
            )
        ]
//        tableView.reloadData()
    }
}
