//
//  GameFieldCell.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 03.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class GameFieldCell: UICollectionViewCell {
    func configCell(gameEngine: GameEngine, cellIndexPath: IndexPath) {
    
        for view in subviews {
            view.removeFromSuperview()
        }
        
        guard let player = gameEngine.checkPlayerMove(at: (x: cellIndexPath.item, y: cellIndexPath.section)) else {
            return
        }
        
        
        switch player {
        case .X:
            addSubview(XMarkView(frame: bounds))
            break
        case .O:
            addSubview(OMarkView(frame: bounds))
            break
        }
    }
}
