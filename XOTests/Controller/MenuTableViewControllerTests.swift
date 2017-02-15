//
//  MenuTableViewControllerTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 31.01.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class MenuTableViewControllerTests: XCTestCase {
    var sut: MenuTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        
        _ = sut.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // имеется таблица, подключена
    func test_hasTableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    // у таблицы определен источник данных
    func test_tableView_setsDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is MenuDataProvider)
    }
    
    // у таблицы определен делегат
    func test_tableView_setsDelegate() {
        XCTAssertTrue(sut.tableView.delegate is MenuDataProvider)
    }
    
    // стиль таблицы - группированный
    func test_tableViewHasGroupedStyle() {
        XCTAssertEqual(sut.tableView.style, UITableViewStyle.grouped)
    }
    
    // таблицы не скролится 
    func test_tableViewHasNoBounces() {
        XCTAssertFalse(sut.tableView.bounces)
    }
    
    // оповещение о нажатии в таблице "Меню" вызывает метод selectedMenuRow
    func test_notificationSelectMenuRow_gotCalledSelectedMenuRow() {
        let sut = MockMenuTableViewController()
        _ = sut.view
        
        NotificationCenter.default.post(name: NSNotification.Name("SelectMenuRow"), object: nil, userInfo: nil)
        
        XCTAssertTrue(sut.gotCalledSelectMenuRow)
    }
    
    // оповещение о нажатии в таблице "Меню" на строке "Игра" представляет GameViewController
    func test_selectedMenuRow_pushedViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let swrevealVC = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        UIApplication.shared.keyWindow?.rootViewController = swrevealVC
        
        let nsNotification = NSNotification(name: NSNotification.Name("SelectMenuRow"), object: nil, userInfo: ["indexPath" : IndexPath(row: 1, section: 0)])
        
        sut.selectedMenuRow(sender: nsNotification)
        
        XCTAssertNotNil(swrevealVC.frontViewController)
        XCTAssertTrue(swrevealVC.frontViewController is UINavigationController)
        XCTAssertTrue(swrevealVC.frontViewController.childViewControllers[0] is GameViewController)
    }

    // TODO оповещение о нажатии в таблице "Меню" на строке ...
    
}

// MARK: - Mock
extension MenuTableViewControllerTests {
    class MockMenuTableViewController: MenuTableViewController {
        
        var gotCalledSelectMenuRow = false
        
        override func selectedMenuRow(sender: NSNotification) {
            gotCalledSelectMenuRow = true
        }
    }
}
