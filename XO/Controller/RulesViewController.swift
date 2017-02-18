//
//  RulesViewController.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 15.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
