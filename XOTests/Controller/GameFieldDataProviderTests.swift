//
//  GameFieldDataProviderTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 01.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class GameFieldDataProviderTests: XCTestCase {
    var sut: GameFieldDataProvider!
    var gameField: UICollectionView!
    var controller: GameViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        sut = GameFieldDataProvider()
        
        controller.gameFieldDataProvider = sut
        
        _ = controller.view
        
        gameField = controller.gameFieldCollectionView
        
        gameField.reloadData()
        
        controller.view.layoutIfNeeded()
    }
    
    override func tearDown() {
        controller.gameEngine.moves.removeAll()
        
        super.tearDown()
    }

    // количество секий - 3
    func test_numberOfSection_equal3() {
        XCTAssertEqual(gameField.numberOfSections, 3)
    }
    
    // количество пунктов в каждой секции - 3
    func test_numberOfItemsInAllSections_equal3() {
        XCTAssertEqual(gameField.numberOfItems(inSection: 0), 3)
        XCTAssertEqual(gameField.numberOfItems(inSection: 1), 3)
        XCTAssertEqual(gameField.numberOfItems(inSection: 2), 3)
    }
    
    // размер отступа между ячейками
    func test_breakItemLineWidth_equalThree() {
        XCTAssertEqual(sut.lineWidth, 3)
    }
    
    // TODO
    // ячейка должна иметь класс
    
    // TODO
    // вызывается конфигурация ячейки
    func _test_cellForItem_callsConfigCell() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        let sut = GameFieldDataProvider()
        
        controller.gameFieldDataProvider = sut
        controller.gameFieldCollectionView = MockGameFieldCollectionView.mockGameFieldCollectionView(withDataProvider: sut, withWidth: 320)
        
        _ = controller.view
        
        let mockGameField = controller.gameFieldCollectionView
        
        mockGameField?.reloadData()
        
        controller.view.layoutIfNeeded()

        let cell = mockGameField?.cellForItem(at: IndexPath(row: 0, section: 0)) as! MockGameFiedlCell
        
        XCTAssertTrue(cell.gotCalledConfigCell)
    }
    
    // TODO
    // размер ячейки
    
    // TODO отступы между ячейками секциями и строками
    
    
    // выбор ячейки отрабатывается для всех ячеек
    func test_selectItemForAllItems_selectedItem() {
        gameField.reloadData()
        
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 0, section: 0)))
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 1, section: 0)))
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 2, section: 0)))
        
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 0, section: 1)))
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 1, section: 1)))
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 2, section: 1)))
        
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 0, section: 2)))
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 1, section: 2)))
        XCTAssertTrue(gameField.delegate!.collectionView!(gameField, shouldSelectItemAt: IndexPath(item: 2, section: 2)))
    }
    
    // оповещение о нажатии на ячейку
    func test_selectItem_notification() {
        
        expectation(forNotification: "SelectGameFieldCell", object: nil) { (notification) -> Bool in
            
            guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else {
                return false
            }
            
            return indexPath == IndexPath(item: 0, section: 0)
        }
        
        gameField.delegate?.collectionView!(gameField, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

// MARK: Mock
extension GameFieldDataProviderTests {
    class MockGameFieldCollectionView: UICollectionView {
        var gotDequeued = false
    
        override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
            gotDequeued = true
            
            return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
        
        class func mockGameFieldCollectionView(withDataProvider dataPdovider: (UICollectionViewDelegate & UICollectionViewDataSource), withWidth width: CGFloat) -> MockGameFieldCollectionView{
            
            let frame = CGRect(x: 0, y: 0, width: width, height: width)
            let layout = UICollectionViewLayout()
            let mockGF = MockGameFieldCollectionView(frame: frame, collectionViewLayout: layout)
            
            mockGF.dataSource = dataPdovider
            mockGF.delegate = dataPdovider
            
            // заегистрировать ячейку
            mockGF.register(MockGameFiedlCell.self, forCellWithReuseIdentifier: "GameFieldCell")
        
            return mockGF
        }
    }
    
    class MockGameFiedlCell: GameFieldCell {
        var gotCalledConfigCell = false
        
        func configCell() {
            gotCalledConfigCell = true
        }
    }
    
}
