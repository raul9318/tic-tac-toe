//
//  GameEngine.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 06.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import Foundation

enum Player: Int {
    case X
    case O
}

class GameEngine: NSObject {
    var currentMove: Player = Player.X
    var countOfMoves: Int {
        return moves.count
    }
    let maxCountOfMoves: Int = 9
    var gameover: Bool {
        get {
            guard winner == nil else {
                return true
            }
            
            guard countOfMoves >= maxCountOfMoves else {
                return false
            }
            
            return true
        }
        set {
            
        }
    }
    var winner: Player?
    
    var moves = [GameEngineMove]()
    var lastMove: GameEngineMove? {
        return moves.last
    }
    
    fileprivate let currentMoveRawValueKey = "currentMoveRawValue"
    fileprivate let winnerRawValueKey = "winnerRawValue"
    fileprivate let movesDictKey = "movesDict"
    fileprivate let gameoverKey = "gameover"
    var plistDict: [String: Any] {
        var dict = [String: Any]()
        
        dict[currentMoveRawValueKey] = self.currentMove.rawValue
        
        if self.winner != nil {
            dict[winnerRawValueKey] = self.winner!.rawValue
        }
        
        var movesDict = [[String: Any]]()
        for move in self.moves {
            movesDict.append(move.plistDict)
        }
        dict[movesDictKey] = movesDict
        
        dict[gameoverKey] = self.gameover
        
        return dict
    }
    
    var currentGameURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentURL = fileURLs.first else {
            print("Document URL could not be found")
            fatalError()
        }
        
        return documentURL.appendingPathComponent("currentGame.plist")
        
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveCurrentGame), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init?(loadCurrentGame: Bool) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveCurrentGame), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        guard loadCurrentGame else {
            return
        }
        
        if let nsGameEngineData = NSArray(contentsOf: currentGameURL) {
            if let gameEngineDict = nsGameEngineData.firstObject {
                
                _ = setPropertiesFrom(dict: gameEngineDict as! [String: Any])
            }
        }
    }
    
    init?(dict: [String: Any]) {
        super.init()
        
        guard setPropertiesFrom(dict: dict) == false else {
            return
        }
        
        return nil
    }
    
    func setPropertiesFrom(dict: [String: Any]) -> Bool {
        guard let currentMoveRawValue = dict[currentMoveRawValueKey] as? Int else {
            return false
        }
        
        guard let playerMove = Player(rawValue: currentMoveRawValue) else {
            return false
        }
        
        self.currentMove = playerMove
        
        if let winnerRawValue = dict[winnerRawValueKey] as? Int {
            guard  let winnerPalayer = Player(rawValue: winnerRawValue) else {
                return false
            }
            
            self.winner = winnerPalayer
        }
        
        if let movesDict = dict[movesDictKey] as? [[String: Any]] {
            
            for moveDict in movesDict {
                guard let move = GameEngineMove(dict: moveDict) else {
                    return false
                }
                
                moves.append(move)
            }
            
        }
        
        guard let gameover = dict[gameoverKey] as? Bool else {
            return false
        }
        
        self.gameover = gameover
        
        return true
    }
    
    func saveCurrentGame() {
        let nsCurrentGame = [plistDict]
        
        guard countOfMoves > 0 else {
            try? FileManager.default.removeItem(at: currentGameURL)
            return
        }
        
        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: nsCurrentGame, format: .xml, options: .init())
            try plistData.write(to: currentGameURL, options: .atomic)
        } catch {
            print(error)
        }

    }
    
    // TODO test
    func removeCurrentGame() {
        try? FileManager.default.removeItem(at: currentGameURL)
    }
    
    func move(to move: GameEngineMove?) {
        
        guard lastMove?.player != move?.player else {
            return
        }
        
        guard gameover == false else {
            return
        }
        
        guard let move = move else {
            return
        }
        
        guard !moves.contains(move) else {
            return
        }
        
        switch currentMove {
        case .X:
            currentMove = Player.O
        case .O:
            currentMove = Player.X
        }
        
        moves.append(move)
        
        checkWinner()
        sendNotificationIfGameIsOver()
    }
    
    func sendNotificationIfGameIsOver() {
        if gameover {
            NotificationCenter.default.post(name: NSNotification.Name("GameOver"), object: self, userInfo: ["winner" : self.winner as Any])
        }
    }
    
    func checkWinner() {
        var winner: Player?
        
        // left to right
        for y in 0...2 {
            
            var lastMove: GameEngineMove?
            
            for x in 0...2 {
                
                let indexOfMove = moves.index(where: { (move) -> Bool in
                    guard move.coordinates == (x: x, y: y) else {
                        return false
                    }
                    return true
                })
                
                guard let index = indexOfMove else {
                    break
                }
                
                let move = moves[index]
                
                if let lastMove = lastMove {
                    if move.player != lastMove.player {
                        break
                    } else if x == 2 {
                        winner = move.player
                    }
                }
                
                lastMove = move
            }
            
            if winner != nil {
                break
            }
            
        }
        
        // up to down
        
        guard winner == nil else {
            self.winner = winner
            return
        }
        
        for x in 0...2 {
            
            var lastMove: GameEngineMove?
            
            for y in 0...2 {
                
                let indexOfMove = moves.index(where: { (move) -> Bool in
                    guard move.coordinates == (x: x, y: y) else {
                        return false
                    }
                    return true
                })
                
                guard let index = indexOfMove else {
                    break
                }
                
                let move = moves[index]
                
                if let lastMove = lastMove {
                    if move.player != lastMove.player {
                        break
                    } else if y == 2 {
                        winner = move.player
                    }
                }
                
                lastMove = move
            }
            
            if winner != nil {
                break
            }
            
        }
        
        // first diagonal
        guard winner == nil else {
            self.winner = winner
            return
        }
        
        var lastMove: GameEngineMove?
        
        for x in 0...2 {
            
            let y = x
            
            let indexOfMove = moves.index(where: { (move) -> Bool in
                guard move.coordinates == (x: x, y: y) else {
                    return false
                }
                return true
            })
            
            guard let index = indexOfMove else {
                break
            }
            
            let move = moves[index]
            
            if let lastMove = lastMove {
                if move.player != lastMove.player {
                    break
                } else if y == 2 {
                    winner = move.player
                }
            }
            
            lastMove = move
            
            if winner != nil {
                break
            }
            
        }
        
        
        // second diagonal
        guard winner == nil else {
            self.winner = winner
            return
        }
        
        lastMove = nil
        
        for x in 0...2 {
            
            let y = 2 - x
            
            let indexOfMove = moves.index(where: { (move) -> Bool in
                guard move.coordinates == (x: x, y: y) else {
                    return false
                }
                return true
            })
            
            guard let index = indexOfMove else {
                break
            }
            
            let move = moves[index]
            
            if let lastMove = lastMove {
                if move.player != lastMove.player {
                    break
                } else if x == 2 {
                    winner = move.player
                }
            }
            
            lastMove = move
            
            if winner != nil {
                break
            }
            
        }
        
        self.winner = winner
    }
    
    func checkPlayerMove(at coordinates: (x: Int, y: Int)) -> Player? {
        
        let index = moves.index { (gameEngineMove) -> Bool in
            return gameEngineMove.coordinates == coordinates
        }
        
        guard index != nil else {
            return nil
        }
        
        return moves[index!].player
    }
}
