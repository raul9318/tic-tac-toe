//
//  LeftMenuTableViewController.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 15.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class LeftMenuTableViewController: UITableViewController {
    @IBOutlet var dataProvider: LeftMenuDataProvider!
    
    override func viewDidLoad() {
        tableView.delegate = dataProvider
    }
}
