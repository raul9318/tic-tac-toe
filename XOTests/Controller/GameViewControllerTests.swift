//
//  GameViewControllerTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 01.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class GameViewControllerTests: XCTestCase {
    var sut: GameViewController!
    var gameField: UICollectionView!
    
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        let gameFieldDataProvider = GameFieldDataProvider()
        sut.gameFieldDataProvider = gameFieldDataProvider
        
        _ = sut.view
        
        gameField = sut.gameFieldCollectionView
        
        gameField.reloadData()
        sut.view.layoutIfNeeded()
    }
    
    override func tearDown() {
        sut.gameEngine.removeCurrentGame()
        
        super.tearDown()
    }
    
    // отступы справа и слева от поля должны быть по 20 px
    func test_leftAndRightMargin_Equal20() {
        XCTAssertEqual(sut.leftMargin, 20)
    }
    
    // определяем квадратные границы поля
    func test_fieldSize() {
        let sut = MockGameViewController.mockGameViewController(withWidth: 320, withHeight: 480)
        _ = sut.view
        
        let fieldSize = sut.fieldSize
        
        XCTAssertEqual(fieldSize.width, 280)
        XCTAssertEqual(fieldSize.width, fieldSize.height)
    }
    
    // TODO: положение подложки на экране
    
    // должно иметься collecion view
    func test_hasGameFieldCollectionView() {
        XCTAssertNotNil(sut.gameFieldCollectionView)
    }
    
    // TODO: Удалить
    // заданы размеры поля
    func gameFieldCollectionViewSize_equalFieldSize() {
        XCTAssertEqual(sut.gameFieldCollectionView.frame.size, sut.fieldSize)
    }
    
    // имеется gameFieldDataProvider
    func test_hasGameFieldDataProvider() {
        XCTAssertNotNil(sut.gameFieldDataProvider)
    }
    
    // после загрузки установлен источник данных для gameFieldCollectionView
    func test_gameFieldCollectionView_setsDataSource() {
        XCTAssertTrue(sut.gameFieldCollectionView.dataSource is GameFieldDataProvider)
    }
    
    // после загрузки установлен делегат для gameFieldCollectionView
    func test_gameFieldCollectionView_sestDelegate() {
        XCTAssertTrue(sut.gameFieldCollectionView.delegate is GameFieldDataProvider)
    }
    
    // делегат и источник данных - один и тот же класс
    func test_gameFieldCollectionViewDelegateAndDataSource_areSameClass() {
        XCTAssertTrue(sut.gameFieldCollectionView.delegate === sut.gameFieldCollectionView.dataSource)
    }
    
    // TODO
    // установлен collectionLayout для gameFieldCollectionView 
    func gameFieldCollectionView_setsCollectionLayout() {
        
    }
    
    // движок игры не nil после загрузки
    func test_hasGameEngine_afterLoad() {
        XCTAssertNotNil(sut.gameEngine)
    }
    
    // первый выбор поля ставит метку X на поле
    // рамка метки равна границам ячейки
    func _test_selectGameFieldCell_addXMarkViewToSubviews() {
        
        // TODO возможно это перенести в тесты самого поля! 
        // TODO mockgamefield
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        let cell = gameField.cellForItem(at: IndexPath(item: 0, section: 0)) as! GameFieldCell
        
        guard let subview = cell.subviews.last else {
            XCTFail(); return
        }
        
        XCTAssertTrue(subview is XMarkView)
        XCTAssertEqual(subview.frame, cell.bounds)
    }
    
    // выборк ячейки поля вызывает метод "Move" игрового движка
    func _test_GameFieldCollectionView_selectingCell_calledMoveInGameEngine() {
        
        var mockGameEngine: MockGameEngine? = MockGameEngine.mockGameEngine(isGameOver: false)
        sut.gameEngine = mockGameEngine
        
        // TODO возможно это перенести в тесты самого поля!
        // TODO mockGameField
        
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockGameEngine!.gotCalledMove)
    }
    
    // отображение метки зависит от текущего хода в игровом движке
    // рамка метки равна границам ячейки
    func _test_selectGameFieldCelladdsMarkView_likeCurrentMoveInGameEngine() {
        let firstCell = IndexPath(item: 0, section: 0)
        let secondCell = IndexPath(item: 1, section: 0)
        
        // TODO возможно это перенести в тесты самого поля!
        // TODO Mockgamefield
        
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: firstCell)
        
        var cell = gameField.cellForItem(at: firstCell)
        
        guard let subview = cell?.subviews.last else {
            XCTFail(); return
        }
        
        XCTAssertTrue(subview is XMarkView)
        
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: secondCell)
        
        cell = gameField.cellForItem(at: secondCell)
        
        guard let subview2 = cell?.subviews.last else {
            XCTFail(); return
        }
        
        XCTAssertTrue(subview2 is OMarkView)
        
        
    }
    
    // повторный выбор ячейки игрового поля не отрабатывается 
    func _test_selectAlreadySelectedGameFieldCell_dontDoAnything() {
        // TODO возможно это перенести в тесты самого поля!
        // TODO MockGameField
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: IndexPath(item: 0, section: 0))
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertEqual(sut.gameEngine.countOfMoves, 1)
        XCTAssertEqual(sut.gameEngine.currentMove, .O)
    }
    
    // когда игра закончена - не делать ходов
    func _test_whenGameIsOver_doNotSelectGameFieldCell() {
        var mockGameEngine: MockGameEngine? = MockGameEngine.mockGameEngine(isGameOver: true)
        sut.gameEngine = mockGameEngine
        
        // TODO возможно это перенести в тесты самого поля!
        // TODO MockgameField
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertFalse(mockGameEngine!.gotCalledMove)
    }

    // лейбл с текстом победителя
    func test_hasWinnerLabel() {
        XCTAssertNotNil(sut.winnerLabel)
    }
    
    // после инициализации текс лейбла победитель пустой
    func test_winnerLabelTextIsEmpty_afterLoading() {
        XCTAssertEqual(sut.winnerLabel.text, "")
    }
    
    // кнопка новой игры
    func test_hasNewGameButton() {
        XCTAssertNotNil(sut.newGameButton)
    }
    
    // кнопка новой игры имеет действие
    func test_newGameButton_hasAction() {
        let button = sut.newGameButton
        
        guard let actions = button?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail(); return
        }
        
        XCTAssertTrue(actions.contains("newGame"))
    }
    
    // новая игра делает сброс игрового движка
    // и обнуляет текст лейбла победителя
    func test_newGame_resetGameEngineAndTextOfWinnerLabel() {
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        let gameFieldDataProvider = GameFieldDataProvider()
        sut.gameFieldDataProvider = gameFieldDataProvider
        
        _ = sut.view
        
        let gameField = sut.gameFieldCollectionView
        
        gameField?.reloadData()
        sut.view.layoutIfNeeded()
        
        sut.winnerLabel.text = "asdf"
        
        let firstGameEngine = sut.gameEngine
        
        sut.newGame()
        
        XCTAssertEqual(sut.winnerLabel.text, "")
        XCTAssertFalse(firstGameEngine === sut.gameEngine)
    }

    // TODO: новая игра вызывает reload игрового поля
    
    // оповещение о конце игры изменяет winnerLabel
    // когда побеждает X
    func test_gameOverNotification_changesWinnerLabelText_WhenXPlayerWinner() {
        NotificationCenter.default.post(name: NSNotification.Name("GameOver"), object: nil, userInfo: ["winner" : Player.X as Any])
        
        XCTAssertEqual(sut.winnerLabel.text, "Победил X")
    }
    
    // оповещение о конце игры изменяет winnerLabel
    // когда побеждает O
    func test_gameOverNotification_changesWinnerLabelText_WhenOPlayerWinner() {
        NotificationCenter.default.post(name: NSNotification.Name("GameOver"), object: nil, userInfo: ["winner" : Player.O as Any])
        
        XCTAssertEqual(sut.winnerLabel.text, "Победил O")
    }
    
    // оповещение о конце игры изменяет winnerLabel
    // когда ничья
    func test_gameOverNotification_changesWinnerLabelText_WhenDraw() {
        NotificationCenter.default.post(name: NSNotification.Name("GameOver"), object: nil, userInfo: ["winner" : (Any).self])
        
        XCTAssertEqual(sut.winnerLabel.text, "Ничья")
    }
    
    // после загрузки устанавливается gameEngine для провайдера данных поля
    func test_setsGameEngine_forGameFieldDataProvider() {
        XCTAssertNotNil(sut.gameFieldDataProvider.gameEngine)
        XCTAssertTrue(sut.gameEngine === sut.gameFieldDataProvider.gameEngine)
    }
    
    // после загрузки - загружается текущая игра
    func test_loadCurrentGame_afterLoadView() {
        var gameEngine: GameEngine? = GameEngine()
        
        let move = GameEngineMove(player: .X, x: 2, y: 2)
        XCTAssertNotNil(move)
        
        gameEngine!.move(to: move)
        gameEngine?.saveCurrentGame()
        gameEngine = nil
        
        XCTAssertNil(gameEngine)
        
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        _ = sut.view
        
        gameEngine = sut.gameEngine
        
        XCTAssertNotNil(gameEngine)
        XCTAssertEqual(gameEngine!.countOfMoves, 1)
        XCTAssertEqual(gameEngine!.currentMove, Player.O)
        XCTAssertEqual(gameEngine!.moves.last, move)
    }
    
    

}

// MARK: Mock
extension GameViewControllerTests {
    class MockGameViewController: GameViewController {
        class func mockGameViewController(withWidth width: CGFloat, withHeight height: CGFloat, allreadySelectedCells: [IndexPath]? = nil) -> MockGameViewController{
            let mockGVC = MockGameViewController()
            
            mockGVC.view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            
            mockGVC.alreadySelectedGameCells = allreadySelectedCells ?? []

            return mockGVC
        }
    }
    
    
    class MockGameEngine: GameEngine {
        class func mockGameEngine(isGameOver: Bool) -> MockGameEngine {
            let el = MockGameEngine()
            
            el.mockGameOver = isGameOver
            
            return el
        }
        
        var gotCalledMove = false
        var mockGameOver: Bool?
        
        override var gameover: Bool {
            get {
                return mockGameOver ?? super.gameover
            }
            set {
                super.gameover = newValue
            }
        }
        
        override func move(to move: GameEngineMove?) {
            gotCalledMove = true
            
            super.move(to: move)
        }
    }
    
    class MockGameField: UICollectionView {
        class func mockGameField() -> MockGameField{
            let mgf = MockGameField(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: UICollectionViewLayout())
            
            return mgf
        }
        var gotReloadedData = false
        
        override func reloadData() {
            gotReloadedData = true
            super.reloadData()
        }
    }
}
