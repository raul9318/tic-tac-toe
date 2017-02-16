//
//  GameEngineTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 06.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class GameEngineTests: XCTestCase {
    var sut: GameEngine!
    
    override func setUp() {
        super.setUp()
        
        sut = GameEngine()
    }
    
    override func tearDown() {
        sut.removeCurrentGame()
        
        super.tearDown()
    }
    
    
    // при первоначальной инициализации заданы начальыне параметры
    // текущий ход, количество ходов, игра завершена, победитель
    func test_initially_setsParamsToOriginalState() {
        XCTAssertEqual(sut.currentMove, Player.X)
        XCTAssertEqual(sut.countOfMoves, 0)
        XCTAssertFalse(sut.gameover)
        XCTAssertNil(sut.winner)
    }
    
    // ход увеличивыет количество ходов
    func test_Move_changesCountOfMoves() {
        sut.move(to: GameEngineMove(player: .X, x: 0, y: 0))
        XCTAssertEqual(sut.countOfMoves, 1)
        
        sut.move(to: GameEngineMove(player: .O, x: 0, y: 1))
        XCTAssertEqual(sut.countOfMoves, 2)
    }
    
    // ход изменяет текущий ход
    func test_Move_changesCurrentMove() {
        sut.move(to: GameEngineMove(player: .X, x: 0, y: 0))
        XCTAssertEqual(sut.currentMove, Player.O)
        
        sut.move(to: GameEngineMove(player: .O, x: 0, y: 1))
        XCTAssertEqual(sut.currentMove, Player.X)
    }
    
    // не делать ход если координаты нет
    func test_Move_whenCoordinateNilDontMove() {
        sut.move(to: nil)
        XCTAssertEqual(sut.countOfMoves, 0)
    }
    
    // нельзя сделать повторный ход
    func test_Move_equalMovesDontMove() {
        let move = GameEngineMove(player: .X, x: 0, y: 0)
        sut.move(to: move)
        sut.move(to: move)
        
        XCTAssertEqual(sut.countOfMoves, 1)
        XCTAssertEqual(sut.currentMove, Player.O)
    }
    
    // один и тот же игрок не может ходить дважды
    func test_onePlayerDontMoveTwoTimes() {
        sut.move(to: GameEngineMove(player: .X, x: 0, y: 0))
        sut.move(to: GameEngineMove(player: .X, x: 0, y: 1))
        
        XCTAssertEqual(sut.countOfMoves, 1)
        XCTAssertEqual(sut.currentMove, .O)
    }
    
    // максимальное количество ходов 3 x 3 = 9
    func test_maxCountOfMoves_equalNine() {
        XCTAssertEqual(sut.maxCountOfMoves, 9)
    }
    
    // игра закончена если достигнуто максимально число ходов
    func test_gameOver_whenCountOfMoves_moreThenMaxMovesCount() {
        let sut: MockGameEngine? = MockGameEngine(mockCountOfMoves: 9)
        
        XCTAssertTrue(sut!.gameover)
    }
    
    // после хода, если количество ходов равно максимальному количеству - игра закончена
    func test_whenCountOfMovesEqualMaxCount_thanGameOver() {
        
        sut.move(to: GameEngineMove(player: .X, x: 0, y: 0))
        sut.move(to: GameEngineMove(player: .O, x: 1, y: 0))
        sut.move(to: GameEngineMove(player: .X, x: 2, y: 0))
        
        sut.move(to: GameEngineMove(player: .O, x: 0, y: 1))
        sut.move(to: GameEngineMove(player: .X, x: 1, y: 1))
        sut.move(to: GameEngineMove(player: .O, x: 2, y: 1))
        
        sut.move(to: GameEngineMove(player: .X, x: 0, y: 2))
        sut.move(to: GameEngineMove(player: .O, x: 1, y: 2))
        sut.move(to: GameEngineMove(player: .X, x: 2, y: 2))
        
        XCTAssertTrue(sut.gameover)
    }
    
    // невозможен ход если игра закончена
    func test_whenGameOver_dontMove() {
        let sut: MockGameEngine? = MockGameEngine(mockCountOfMoves: 3, mockGameOver: true)
        
        sut!.move(to: GameEngineMove(player: .O, x: 0, y: 1))
        
        XCTAssertEqual(sut!.countOfMoves, 3)
    }
    
    // проверка на победителя должна производиться в конце хода
    func test_calledCheckWinner_whenEndMove() {
        let sut: MockGameEngine? = MockGameEngine()
        
        sut!.move(to: GameEngineMove(player: .X, x: 0, y: 0))
        
        XCTAssertTrue(sut!.gotCalledCheckWinner)
    }
    
    // если победитель названачен - игра закончена
    func test_gameOver_whenWinnerIsNotNil() {
        sut.winner = Player.O
        
        XCTAssertTrue(sut.gameover)
    }
    
    // победитель X, если заполнена линия 1 по X
    func test_xWinner_whenAllMarksOnLineOneOnX() {
        makeWinner(player: .X, onLine: 0)
    }
    
    // победитель X, если заполнена линия 2 по X
    func test_xWinner_whenAllMarksOnLineTwoOnX () {
        makeWinner(player: .X, onLine: 1)
    }
    
    // победитель X, если заполнена линия 3 по X
    func test_xWinner_whenAllMarksOnLineThreeOnX() {
        makeWinner(player: .X, onLine: 2)
    }
    
    // победитель X, если заполнена линия 1 по Y
    func test_xWinner_whenAllMarksOnLineOneOnY() {
        makeWinnerOnY(player: .X, onLine: 0)
    }
    
    // победитель X, если заполнена линия 2 по Y
    func test_xWinner_whenAllMarksOnLineTwoOnY() {
        makeWinnerOnY(player: .X, onLine: 1)
    }
    
    // победитель X, если заполнена линия 3 по Y
    func test_xWinner_whenAllMarksOnLineThreeOnY() {
        makeWinnerOnY(player: .X, onLine: 2)
    }
    
    // победитель X, если заполнена диагональ 1
    func test_xWinner_onFirstDiagonal() {
        makeWinnerOnXY(player: .X)
    }
    
    // победитель X, если заполнена диагональ 2
    func test_xWinner_onSecondDiagonal() {
        makeWinnerOnYX(player: .X)
    }
    
    
    // победитель O, если заполнена линия 1 по X
    func test_oWinner_whanAllMarksOnLineOneOnX() {
        makeWinner(player: .O, onLine: 0)
    }
    
    // победитель O, если заполнена линия 2 по X
    func test_oWinner_whanAllMarksOnLineTwiOnX() {
        makeWinner(player: .O, onLine: 1)
    }
    
    // победитель O, если заполнена линия 3 по X
    func test_oWinner_whanAllMarksOnLineThreeOnX() {
        makeWinner(player: .O, onLine: 2)
    }
    
    // победитель O, если заполнена линия 1 по Y
    func test_oWinner_whenAllMarksOnLineOneOnY() {
        makeWinnerOnY(player: .O, onLine: 0)
    }
    
    // победитель O, если заполнена линия 2 по Y
    func test_oWinner_whenAllMarksOnLineTwoOnY() {
        makeWinnerOnY(player: .O, onLine: 1)
    }
    
    // победитель O, если заполнена линия 3 по Y
    func test_oWinner_whenAllMarksOnLineThreeOnY() {
        makeWinnerOnY(player: .O, onLine: 2)
    }
    
    // победитель O, если заполнена диагональ 1
    func test_oWinner_onFirstDiagonal() {
        makeWinnerOnXY(player: .O)
    }
    
    // победитель O, если заполнена диагональ 2
    func test_oWinner_onSecondDiagonal() {
        makeWinnerOnYX(player: .O)
    }
    
    // ничья
    func test_drawGame() {
        sut.moves = [
            GameEngineMove(player: .X, x: 1, y: 1)!,
            GameEngineMove(player: .O, x: 0, y: 0)!,
            
            GameEngineMove(player: .X, x: 0, y: 1)!,
            GameEngineMove(player: .O, x: 1, y: 2)!,
            
            GameEngineMove(player: .X, x: 0, y: 2)!,
            GameEngineMove(player: .O, x: 2, y: 0)!,
            
            GameEngineMove(player: .X, x: 0, y: 1)!,
            GameEngineMove(player: .O, x: 2, y: 1)!,
            
            GameEngineMove(player: .X, x: 2, y: 2)!,
        ]
        
        sut.checkWinner()
        
        XCTAssertTrue(sut.gameover)
        XCTAssertNil(sut.winner)
    }
    
    // после каждого хода вызывается проверка на конец игры
    func test_gotCalledSecnNotificationIfGameIsOver_afterMove() {
        let sut: MockGameEngine? = MockGameEngine(mockCountOfMoves: nil, mockGameOver: false)
        
        sut!.move(to: GameEngineMove(player: .X, x: 0, y: 0))
        XCTAssertTrue(sut!.gotCalledSendNotificaitionIfGameIsOver)
    }
    
    // ожидается оповещение с победителем X если игра завершена
    func test_wiinerX_getNotification() {
        makeMockWinnerSendNotification(winner: Player.X)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // ожидается оповещение с победителем O если игра завершена
    func test_wiinerO_getNotification() {
        makeMockWinnerSendNotification(winner: Player.O)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // ожидается оповещение, нет победителя, игра завершена
    func test_noWinner_getNotification() {
        makeMockWinnerSendNotification(winner: nil)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // имеется свойство plistDict
    func test_hasPlistDict() {
        let plistDict = sut.plistDict
        
        XCTAssertNotNil(plistDict)
        XCTAssertTrue(plistDict is [String: Any])
    }
    
    // игровой движок можно воссаздать из словаря
    func test_recreatedGameEngineFromDict() {
        let fakeGameEngine: FakeGameEngine? = FakeGameEngine()
        
        let dict = fakeGameEngine!.plistDict
        
        XCTAssertNotNil(dict)
        
        let recreatedGameEngine = GameEngine(dict: dict)
        
        XCTAssertEqual(fakeGameEngine!.currentMove, recreatedGameEngine?.currentMove)
        XCTAssertEqual(fakeGameEngine!.winner, recreatedGameEngine?.winner)
        XCTAssertEqual(fakeGameEngine!.countOfMoves, recreatedGameEngine?.countOfMoves)
        XCTAssertEqual(fakeGameEngine!.gameover, recreatedGameEngine?.gameover)
    }
    
    // когда устройство не активно сохраняются данные текущей игры
    func test_gameEngineSerializedData() {
        let moves: [GameEngineMove] = [
            GameEngineMove(player: .X, x: 0, y: 0)!,
            GameEngineMove(player: .X, x: 1, y: 0)!,
            GameEngineMove(player: .X, x: 2, y: 0)!
        ]
        
        var gameEngine: GameEngine? = MockGameEngine(moves: moves, currentMove: Player.O)!
        
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        gameEngine = nil
        
        XCTAssertNil(gameEngine)
        
        gameEngine = GameEngine(loadCurrentGame: true)
        
        XCTAssertNotNil(gameEngine)
        XCTAssertEqual(gameEngine?.currentMove, Player.O)
        XCTAssertEqual(gameEngine?.countOfMoves, 3)
        XCTAssertEqual((gameEngine?.moves)!, moves)
    }
    
    // проверка существования X метки
    func test_checkPlayerMoveAtCoordinates_returnsXPlayerOfMove() {
        testingMoveAtCoordinate((x: 0, y: 0), player: Player.X)
    }
    
    // проверка существования O метки
    func test_checkPlayerMoveAtCoordinates_returnsOPlayerOfMove() {
        testingMoveAtCoordinate((x: 0, y: 0), player: Player.O)
    }
    
    // не существует метки в поле с координатами
    func test_checkPlayerMoveAtCoordinates_returnsNil() {
        testingMoveAtCoordinate((x: 0, y: 0), player: nil)
    }
    
    // ожидается выигрышная комбинация по первой горизонтальной линии
    func test_checkWinner_setsFirstHorizontalWinnerLine() {
        let line = 0
        makeWinner(player: .X, onLine: line)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Horizon(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по второй горизонтальной линии
    func test_checkWinner_setsSecondHorizontalWinnerLine() {
        let line = 1
        makeWinner(player: .X, onLine: line)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Horizon(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по третей горизонтальной линии
    func test_checkWinner_setsThirdHorizontalWinnerLine() {
        let line = 2
        makeWinner(player: .X, onLine: line)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Horizon(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по первой вертикальной линии
    func test_checkWinner_setsFirstVerticalWinnerLine() {
        let line = 0
        makeWinnerOnY(player: .X, onLine: line)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Vertical(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по второй вертикальной линии
    func test_checkWinner_setsSecondVerticalWinnerLine() {
        let line = 1
        makeWinnerOnY(player: .X, onLine: line)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Vertical(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по третей вертикальной линии
    func test_checkWinner_setsThirdVerticalWinnerLine() {
        let line = 2
        makeWinnerOnY(player: .X, onLine: line)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Vertical(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по главной диагонали
    func test_checkWinner_setsMainDiagonalWinnerLine() {
        let line = 0
        makeWinnerOnXY(player: .X)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Diagonal(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // ожидается выигрышная комбинация по обратной диагонали
    func test_checkWinner_setsSecondDiagonalWinnerLine() {
        let line = 1
        makeWinnerOnYX(player: .X)
        
        sut.checkWinner()
        
        let winnerLine: WinnerLine? = WinnerLine.Diagonal(line)
        
        XCTAssertNotNil(sut.winnerLine)
        XCTAssertEqual(sut.winnerLine, winnerLine)
    }
    
    // нет выигрышной линии
    func test_checkWinner_winnerLineIsNil() {
        sut.checkWinner()
        
        XCTAssertNil(sut.winnerLine)
    }
    
    
}

extension GameEngineTests {
    fileprivate func testingMoveAtCoordinate(_ coordinate: (x: Int, y: Int), player: Player?, line: UInt = #line) {
        
        if player != nil {
            let move = GameEngineMove(player: player!, x: coordinate.x, y: coordinate.y)
            sut.move(to: move)
        }
        
        let checkPlayer = sut.checkPlayerMove(at: coordinate)
        
        XCTAssertEqual(checkPlayer, player, "Line: \(line)")
    }
    
    fileprivate func makeMockWinnerSendNotification(winner: Player?) {
        let sut = MockGameEngine(winner: winner, gameover: true)
        
        expectation(forNotification: "GameOver", object: nil) { (notification) -> Bool in
            
            guard let userInfo = notification.userInfo else {
                return false
            }
            
            let winnerFromN = userInfo["winner"] as? Player
            
            return winnerFromN == winner
        }
        
        sut!.sendNotificationIfGameIsOver()
    }
    
    fileprivate func makeWinner(player: Player, onLine: Int, line: UInt = #line) {
        
        sut.moves = [
            GameEngineMove(player: player, x: 0, y: onLine)!,
            GameEngineMove(player: player, x: 1, y: onLine)!,
            GameEngineMove(player: player, x: 2, y: onLine)!
        ]
        
        sut.checkWinner()
        
        XCTAssertEqual(sut.winner, player, "Line: \(line)")
        XCTAssertTrue(sut.gameover, "Line: \(line)")
    }
    
    fileprivate func makeWinnerOnY(player: Player, onLine: Int, line: UInt = #line) {
        
        sut.moves = [
            GameEngineMove(player: player, x: onLine, y: 0)!,
            GameEngineMove(player: player, x: onLine, y: 1)!,
            GameEngineMove(player: player, x: onLine, y: 2)!
        ]
        
        sut.checkWinner()
        
        XCTAssertEqual(sut.winner, player, "Line: \(line)")
        XCTAssertTrue(sut.gameover, "Line: \(line)")
    }
    
    fileprivate func makeWinnerOnXY(player: Player, line: UInt = #line) {
        
        sut.moves = [
            GameEngineMove(player: player, x: 0, y: 0)!,
            GameEngineMove(player: player, x: 1, y: 1)!,
            GameEngineMove(player: player, x: 2, y: 2)!
        ]
        
        sut.checkWinner()
        
        XCTAssertEqual(sut.winner, player, "Line: \(line)")
        XCTAssertTrue(sut.gameover, "Line: \(line)")
    }
    
    fileprivate func makeWinnerOnYX(player: Player, line: UInt = #line) {
        
        sut.moves = [
            GameEngineMove(player: player, x: 0, y: 2)!,
            GameEngineMove(player: player, x: 1, y: 1)!,
            GameEngineMove(player: player, x: 2, y: 0)!
        ]
        
        sut.checkWinner()
        
        XCTAssertEqual(sut.winner, player, "Line: \(line)")
        XCTAssertTrue(sut.gameover, "Line: \(line)")
    }
}

// MARK: Mock
extension GameEngineTests {
    
    class MockGameEngine: GameEngine {
        var mockCountOfMoves: Int?
        var mockGameOver: Bool?
        
        var mockWiinerSets = false
        var mockWinner: Player?
        var mockMoves: [GameEngineMove]?
        var mockCurrentMove: Player?
        
        override var countOfMoves: Int {
            if mockCountOfMoves != nil {
                return mockCountOfMoves!
            }
            return super.countOfMoves
        }
        
        override var gameover: Bool {
            get {
                if mockGameOver != nil {
                    return mockGameOver!
                }
                
                return super.gameover
            }
            set {
                super.gameover = newValue
            }
        }
    
        override var winner: Player? {
            get {
                guard self.mockWiinerSets == false else {
                    return self.mockWinner
                }
                return super.winner
            }
            set {
                super.winner = newValue
            }
        }
        
        override var moves: [GameEngineMove] {
            get {
                guard self.mockMoves == nil else {
                    return self.mockMoves!
                }
                return super.moves
            }
            set {
                super.moves = newValue
            }
        }
        
        override var currentMove: Player {
            get {
                guard self.mockCurrentMove == nil else {
                    return self.mockCurrentMove!
                }
                return super.currentMove
            }
            set {
                super.currentMove = newValue
            }
        }
        
        var gotCalledCheckWinner = false
        var gotCalledSendNotificaitionIfGameIsOver = false
        
        override func checkWinner() {
            gotCalledCheckWinner = true
        }
        
        override func sendNotificationIfGameIsOver() {
            gotCalledSendNotificaitionIfGameIsOver = true
            super.sendNotificationIfGameIsOver()
        }
        
        init?(mockCountOfMoves: Int? = nil, mockGameOver: Bool? = nil) {
            super.init()
            self.mockCountOfMoves = mockCountOfMoves
            self.mockGameOver = mockGameOver
        }
        
        init?(winner: Player?, gameover: Bool) {
            super.init()
            mockWinner = winner
            mockWiinerSets = true
            mockGameOver = gameover
        }
        
        init?(moves: [GameEngineMove], currentMove: Player) {
            super.init()
            mockMoves = moves
            mockCurrentMove = currentMove
        }
    }
}

// MARK: - Fake
extension GameEngineTests {
    class FakeGameEngine: GameEngine {
        var fakeCurrentMove = Player.O
        override var currentMove: Player {
            get {
                return self.fakeCurrentMove
            }
            set {
                super.currentMove = newValue
            }
        }
        
        var fakeWinner: Player? = Player.X
        override var winner: Player? {
            get {
                return self.fakeWinner
            }
            set {
                super.winner = newValue
            }
        }
        
        
        var fakeMoves: [GameEngineMove] = [
            GameEngineMove(player: Player.X, x: 0, y: 0)!,
            GameEngineMove(player: Player.O, x: 0, y: 1)!,
            GameEngineMove(player: Player.X, x: 1, y: 0)!
        ]
        override var moves: [GameEngineMove] {
            get {
                return self.fakeMoves
            }
            set {
                super.moves = newValue
            }
        }
        
        var fakeGameover = true
        override var gameover: Bool {
            get {
                return self.fakeGameover
            }
            set {
                super.gameover = newValue
            }
        }
    }
}
