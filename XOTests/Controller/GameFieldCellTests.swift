//
//  GameFieldCellTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 10.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class GameFieldCellTests: XCTestCase {
    var sut: GameFieldCell!
    var fakeGameEngine: GameEngine?
    
    override func setUp() {
        super.setUp()
        
        sut = GameFieldCell()
    }
    
    override func tearDown() {
        fakeGameEngine?.moves.removeAll()
        fakeGameEngine = nil
        
        super.tearDown()
    }

    // не должно быть subviews когда в этой ячейки нет хода
    func test_removeSubviews_whenHasNotMark() {
        fakeGameEngine = FakeGameEngine()
        
        XCTAssertNotNil(fakeGameEngine)
        
        sut.configCell(gameEngine: fakeGameEngine!, cellIndexPath: IndexPath(item: 2, section: 2))
        
        XCTAssertEqual(sut.contentView.subviews.count, 0)
    }
    
    // в ячейке отображается X, когда есть ход в этой ячейке
    func test_configCell_xMark() {
        fakeGameEngine = FakeGameEngine()
        
        XCTAssertNotNil(fakeGameEngine)
        
        fakeGameEngine?.move(to: GameEngineMove(player: Player.X, x: 0, y: 0))
        
        sut.configCell(gameEngine: fakeGameEngine!, cellIndexPath: IndexPath(item: 0, section: 0))
        
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertTrue(sut.subviews.first is XMarkView)
    }
    
    // в ячейке отображается O, когда есть ход в этой ячейке
    // TODO review
    func test_configCell_oMark() {
        fakeGameEngine = FakeGameEngine()
        
        XCTAssertNotNil(fakeGameEngine)
        
        fakeGameEngine?.move(to: GameEngineMove(player: Player.X, x: 1, y: 0))
        
        sut.configCell(gameEngine: fakeGameEngine!, cellIndexPath: IndexPath(item: 1, section: 0))
        
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertTrue(sut.subviews.first is OMarkView)
    }
    
}

// MARK: - Fake
extension GameFieldCellTests {
    class FakeGameEngine: GameEngine {
        override var moves: [GameEngineMove] {
            get {
                return [
                    GameEngineMove(player: .X, x: 0, y: 0)!,
                    GameEngineMove(player: .O, x: 1, y: 0)!
                ]
            }
            set {
                super.moves = newValue
            }
        }
    }
}
