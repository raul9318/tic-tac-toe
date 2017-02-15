//
//  MenuDataProviderTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 31.01.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class MenuDataProviderTests: XCTestCase {
    var sut: MenuDataProvider!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        
        sut = MenuDataProvider()
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
        
        _ = controller.view
        
        tableView.reloadData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // количество секций = 1
    func test_numberOfSectionsEqualOne() {
        XCTAssertEqual(sut.numberOfSections(in: tableView), 1)
    }
    
    // количество строк в секции 1 = 5
    func test_numberOfRowsInFirstSectionEqualFive() {
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 0), 5)
    }
    
    // первая строка таблицы - ячейка "Заголовок приложения"
    func test_cellForFirstRow_returnsMenuTitleCell() {
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is MenuTitleCell)
    }
    
    // строки таблицы от 2й до 5й - ячейка "Строка меню"
    func test_cellForRowsBetweenTwoAndFive_returnMenuRowCell() {
        
        let cell_1 = tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        let cell_2 = tableView.cellForRow(at: IndexPath(row: 2, section: 0))
        let cell_3 = tableView.cellForRow(at: IndexPath(row: 3, section: 0))
        let cell_4 = tableView.cellForRow(at: IndexPath(row: 4, section: 0))
        
        XCTAssertTrue(cell_1 is MenuRowCell)
        XCTAssertTrue(cell_2 is MenuRowCell)
        XCTAssertTrue(cell_3 is MenuRowCell)
        XCTAssertTrue(cell_4 is MenuRowCell)
        
    }
    
    // TODO вынести настроки в отдельные тесты ячеек

    // 1я строка таблицы должна быть сконфигурирована
    func test_configFirstCell_gotCalledConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataProvider: sut)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockMenuTitleCell
        
        XCTAssertTrue(cell.gotCalledConfigCell)
    }
    
    // устанавливается titleLabel 1й строки таблицы - "Названия приложения"
    func test_configurationMenuTitleCell_setsTitleLabel() {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MenuTitleCell
        
        XCTAssertEqual(cell.titleLabel.text, "Крестики-нолики")
    }
    
    // 2-5я строки таблицы должны иметь iconImageView и titleLabel
    func test_cellsBetweenTwoAndFive_haveTitleLabelAndIconImageView() {
        testingMenuRowCell(at: IndexPath(row: 1, section: 0))
        testingMenuRowCell(at: IndexPath(row: 2, section: 0))
        testingMenuRowCell(at: IndexPath(row: 3, section: 0))
        testingMenuRowCell(at: IndexPath(row: 4, section: 0))
    }
    
    // 2-5я строки таблицы должна быть сконфигурирована
    func test_configCellsBetweenTwoAndFive_gotCalledConfigCell() {
        testingCalledConfigMenuRowCell(at: IndexPath(row: 1, section: 0))
        testingCalledConfigMenuRowCell(at: IndexPath(row: 2, section: 0))
        testingCalledConfigMenuRowCell(at: IndexPath(row: 3, section: 0))
        testingCalledConfigMenuRowCell(at: IndexPath(row: 4, section: 0))
    }
    
    // устанавливается titleLabel и iconImageView от 2й по 5ю строки таблицы
    func test_configurationCellBetweenTwoAndFive_setsTitleLabelAndIconImageView() {
        // TODO: иконки
        testingConfigurationCell(at: IndexPath(row: 1, section: 0), withTitle: "Игра", withIconImage: UIImage())
        testingConfigurationCell(at: IndexPath(row: 2, section: 0), withTitle: "Статистика", withIconImage: UIImage())
        testingConfigurationCell(at: IndexPath(row: 3, section: 0), withTitle: "Правила", withIconImage: UIImage())
        testingConfigurationCell(at: IndexPath(row: 4, section: 0), withTitle: "О программе", withIconImage: UIImage())
    }
    
    // одиночный выбор ячейки доступен только для 2-5ю строки
    func test_singleSelectAvailableForIndexFrom1To4() {
        let tableView = UITableView()
        tableView.delegate = sut
        
        XCTAssertNil(tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 0, section: 0)))
        XCTAssertEqual(tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 1, section: 0)), IndexPath(row: 1, section: 0))
        XCTAssertEqual(tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 2, section: 0)), IndexPath(row: 2, section: 0))
        XCTAssertEqual(tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 3, section: 0)), IndexPath(row: 3, section: 0))
        XCTAssertEqual(tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 4, section: 0)), IndexPath(row: 4, section: 0))
        
    }

    // ожидается оповещение от нажания на 1ю строчку меню
    func test_selectFirstMenuRow_getsNotification() {
        expectForNotificationAfterSelectRow(at: IndexPath(row: 1, section: 0))
    }
    
    // ожидается оповещение от нажания на 2ю строчку меню
    func test_selectSecondMenuRow_getsNotification() {
        expectForNotificationAfterSelectRow(at: IndexPath(row: 2, section: 0))
    }
    
    // ожидается оповещение от нажания на 3ю строчку меню
    func test_selectThirdMenuRow_getsNotification() {
        expectForNotificationAfterSelectRow(at: IndexPath(row: 3, section: 0))
    }
    
    // ожидается оповещение от нажания на 4ю строчку меню
    func test_selectFourthMenuRow_getsNotification() {
        expectForNotificationAfterSelectRow(at: IndexPath(row: 4, section: 0))
    }
    
    // TODO
    // не ожидается оповещение на строке заголовка
    func _test_selectTitleRow_doesNotGetsNotification() {
        expectation(forNotification: "SelectMenuRow", object: nil) { (notification) -> Bool in
            
            guard notification.userInfo?["indexPath"] == nil else {
                return false
            }
            
            return true
        }
        
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    

}

extension MenuDataProviderTests {
    fileprivate func expectForNotificationAfterSelectRow(at indexPath: IndexPath) {
        
        expectation(forNotification: "SelectMenuRow", object: nil) { (notification) -> Bool in
            
            guard let indexPathFromN = notification.userInfo?["indexPath"] as? IndexPath else {
                return false
            }
            
            return indexPath == indexPathFromN
        }
        
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }

    
    fileprivate func testingMenuRowCell(at indexPath: IndexPath, line: UInt = #line) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuRowCell
        
        XCTAssertNotNil(cell.titleLabel, "Line: \(line)")
        XCTAssertNotNil(cell.iconImageView, "Line: \(line)")
    }
    
    fileprivate func testingCalledConfigMenuRowCell(at indexPath: IndexPath, line: UInt = #line) {
        let mockTableView = MockTableView.mockTableView(withDataProvider: sut)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: indexPath) as! MockMenuRowCell
        
        XCTAssertTrue(cell.gotCalledConfigCell, "Line: \(line)")
    }
    
    fileprivate func testingConfigurationCell(at indexPath: IndexPath, withTitle title: String, withIconImage iconImage: UIImage, line: UInt = #line) {
        
        let cell = tableView.cellForRow(at: indexPath) as! MenuRowCell
        
        XCTAssertEqual(cell.titleLabel.text, title, "Line: \(line)")
        // TODO XCTAssertEqual(cell.iconImageView.image, iconImage, "Line: \(line)")
    }
}

// MARK: Mock
extension MenuDataProviderTests {
    class MockTableView: UITableView {
        class func mockTableView(withDataProvider dataProvider: MenuDataProvider) -> MockTableView {
            
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 640))
            
            mockTableView.dataSource = dataProvider
            
            mockTableView.register(MockMenuTitleCell.self, forCellReuseIdentifier: "MenuTitleCell")
            mockTableView.register(MockMenuRowCell.self, forCellReuseIdentifier: "MenuRowCell")
            
            return mockTableView
        }
    }
    
    class MockMenuTitleCell: MenuTitleCell {
        var gotCalledConfigCell = false
        override func configCell() {
            gotCalledConfigCell = true
        }
    }
    
    class MockMenuRowCell: MenuRowCell {
        var gotCalledConfigCell = false
        override func configCell(withTitle title: String, withIconImage: UIImage) {
            gotCalledConfigCell = true
        }
    }
}
