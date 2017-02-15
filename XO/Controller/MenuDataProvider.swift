//
//  MenuDataProvider.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 31.01.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

enum MenuRow: Int {
    case Title
    case Game
    case Statistics
    case Rules
    case About
}

class MenuDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.section == 0 else {
            fatalError()
        }
        
        guard let nsRowIndex = MenuRow(rawValue: indexPath.row) else {
            fatalError()
        }
        
        if nsRowIndex == .Title {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTitleCell", for: indexPath) as! MenuTitleCell
            
            cell.configCell()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuRowCell", for: indexPath) as! MenuRowCell
            
            if nsRowIndex == .Game {
                cell.configCell(withTitle: "Игра", withIconImage: UIImage())
            }
            
            if nsRowIndex == .Statistics {
                cell.configCell(withTitle: "Статистика", withIconImage: UIImage())
            }
            
            if nsRowIndex == .Rules {
                cell.configCell(withTitle: "Правила", withIconImage: UIImage())
            }
            
            if nsRowIndex == .About {
                cell.configCell(withTitle: "О программе", withIconImage: UIImage())
            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath == IndexPath(row: 0, section: 0) {
            return nil
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath != IndexPath(row: 0, section: 0) else {
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("SelectMenuRow"), object: self, userInfo: ["indexPath" : indexPath])
    }
}
