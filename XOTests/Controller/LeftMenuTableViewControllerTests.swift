//
//  LeftMenuTableViewControllerTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 15.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class LeftMenuTableViewControllerTests: XCTestCase {
    var sut: LeftMenuTableViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuTableViewController") as! LeftMenuTableViewController
        
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // должен существовать провайдер данных для таблицы
    func test_hasDataProvider() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    // полсе загрузки должен существовать делегат для таблицы
    func test_afterLoad_tableViewDelegat_isDataProvider() {
        XCTAssertTrue(sut.tableView.delegate is LeftMenuDataProvider)
    }
    
}
