//
//  MenuRowCell.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 31.01.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class MenuRowCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    func configCell(withTitle title: String, withIconImage iconImage: UIImage) {
        titleLabel.text = title
        iconImageView.image = iconImage
    }
    
}
