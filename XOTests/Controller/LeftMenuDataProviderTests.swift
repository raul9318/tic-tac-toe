//
//  LeftMenuDataProviderTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 15.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class LeftMenuDataProviderTests: XCTestCase {
    var sut: LeftMenuDataProvider!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        sut = LeftMenuDataProvider()
        tableView = UITableView()
        tableView.delegate = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // первая строка меню не должна нажиматься (эта строка - название программы)
    func test_firstRow_doesNotSelectable() {
        let result = tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNil(result)
    }
    
    // любая другая строка меню нажимается
    func test_otherRow_isSelectable() {
        let result = tableView.delegate?.tableView!(tableView, willSelectRowAt: IndexPath(row: 1, section: 0))
        
        XCTAssertEqual(result, IndexPath(row: 1, section: 0))
    }

    // высота ячеек 64px
    func test_heightForRowAtIndex_equal64() {
        let height = tableView.delegate?.tableView!(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(height, 64)
    }
    
}
