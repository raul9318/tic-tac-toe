//
//  MenuTitleCell.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 31.01.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class MenuTitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func configCell() {
        titleLabel.text = "Крестики-нолики"
    }
}
