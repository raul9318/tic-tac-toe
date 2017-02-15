//
//  MenuTableViewController.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 31.01.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        tableView.bounces = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectedMenuRow(sender:)), name: NSNotification.Name("SelectMenuRow"), object: nil)
    }
    
    func selectedMenuRow(sender: NSNotification) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "GameViewController")
        
        if self.revealViewController() != nil {
            let navigationController = UINavigationController(rootViewController: vc)
            self.revealViewController().pushFrontViewController(navigationController, animated: true)
        }
    }
    
}
