//
//  RoundedImageView.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 18.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {


    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
    }

}
