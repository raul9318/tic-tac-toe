//
//  GameEngineMoveTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 06.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class GameEngineMoveTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // задаются координаты при первоначальной инициализации
    func test_Init_setsCoordinates() {
        let sut = GameEngineMove(player: .X, x: 1, y: 2)
        
        XCTAssertEqual(sut?.coordinates.x, 1)
        XCTAssertEqual(sut?.coordinates.y, 2)
    }
    
    // возвращается nil когда координата X задана больше 2х
    func test_Init_returnsNilWhenXMoreThan2() {
        let sut = GameEngineMove(player: .X, x: 3, y: 0)
        
        XCTAssertNil(sut)
    }
    
    // возвращается nil когда координата X задана меньше 0
    func test_Init_returnsNilWhenXLessThan0() {
        let sut = GameEngineMove(player: .X, x: -1, y: 0)
        
        XCTAssertNil(sut)
    }
    
    // возвращается nil когда координата Y задана больше 2х
    func test_Init_returnsNilWhenYMoreThan3() {
        let sut = GameEngineMove(player: .X, x: 0, y: 3)
        
        XCTAssertNil(sut)
    }
    
    // возвращается nil когда координата Y задана меньше 0
    func test_Init_returnsNilWhenYLessThan0() {
        let sut = GameEngineMove(player: .X, x: 0, y: -1)
        
        XCTAssertNil(sut)
    }
    
    // одинаковые ходы должны быть одинаковыми 
    func test_equtableMoves_areEqual() {
        let firstMove = GameEngineMove(player: .X, x: 0, y: 0)
        let secondMove = GameEngineMove(player: .X, x: 0, y: 0)
        
        XCTAssertEqual(firstMove, secondMove)
    }
    
    // ходы с разными координатами X должны быть не равны
    func test_movesWithDiffersCoordinateX_areNotEqual() {
        let firstMove = GameEngineMove(player: .X, x: 0, y: 0)
        let secondMove = GameEngineMove(player: .X, x: 1, y: 0)
        
        XCTAssertNotEqual(firstMove, secondMove)
    }
    
    // ходы с разными координатами Y должны быть не равны
    func test_movesWithDiffersCoordinateY_areNotEqual() {
        let firstMove = GameEngineMove(player: .X, x: 0, y: 0)
        let secondMove = GameEngineMove(player: .X, x: 0, y: 1)
        
        XCTAssertNotEqual(firstMove, secondMove)
    }
    
    // имеется свойство plistDict
    func test_hasPlistDict() {
        let move = GameEngineMove(player: .X, x: 0, y: 0)!
        
        let dict = move.plistDict as Any
        
        XCTAssertNotNil(dict)
        XCTAssertTrue(dict is [String: Any])
    }
    
    // ход может быть воссоздан из словаря
    func test_canBeRecreatedFromDict() {
        let move = GameEngineMove(player: .X, x: 0, y: 0)!
        
        let dict = move.plistDict
        
        let recreatedMove = GameEngineMove(dict: dict)
        
        XCTAssertEqual(move, recreatedMove)
    }
    
    
    
    
}
