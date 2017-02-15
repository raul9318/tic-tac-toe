//
//  GameEngineMove.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 06.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import Foundation

struct GameEngineMove {
    let player: Player!
    let coordinates: (x: Int, y: Int)
    
    fileprivate let playerRawValueKey = "playerRawValue"
    fileprivate let coordinateXKey = "coordinateX"
    fileprivate let coordinateYKey = "coordinateY"
    var plistDict: [String: Any] {
        
        var dict = [String: Any]()
        
        dict[playerRawValueKey] = self.player.rawValue
        dict[coordinateXKey] = self.coordinates.x
        dict[coordinateYKey] = self.coordinates.y
        
        return dict
    }

    init?(player: Player, x: Int, y: Int) {
        guard x <= 2, x >= 0,
            y <= 2, y >= 0
            else {
                
            return nil
        }
        
        self.player = player
        self.coordinates = (x: x, y: y)
    }
    
    init?(dict: [String: Any]) {
        guard let playerRawValue = dict[playerRawValueKey] as? Int else {
            return nil
        }
        
        guard let coordinateX = dict[coordinateXKey] as? Int else {
            return nil
        }
        
        guard let coordinateY = dict[coordinateYKey] as? Int else {
            return nil
        }
        
        self.player = Player(rawValue: playerRawValue)
        self.coordinates = (x: coordinateX, y: coordinateY)
    }
}

extension GameEngineMove: Equatable {
    static func ==(lhs: GameEngineMove, rhs: GameEngineMove) -> Bool {
        
        guard lhs.coordinates.x == rhs.coordinates.x else {
            return false
        }
        
        guard lhs.coordinates.y  == rhs.coordinates.y else {
            return false
        }
        
        return true
    }
}
