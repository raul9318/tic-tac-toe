//
//  LeftMenuDataProvider.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 15.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class LeftMenuDataProvider: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row != 0 else {
            return nil
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
