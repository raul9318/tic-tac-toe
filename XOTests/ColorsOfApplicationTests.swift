//
//  ColorsOfApplicationTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 19.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class ColorsOfApplicationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Основной цвет приложения (tint color) -  80 120 120 (hex 507878)
    func test_mainColor() {
        XCTAssertEqual(ColorsOfApplication.main, UIColor.init(red: 80 / 255.0, green: 120 / 255.0, blue: 120 / 255.0, alpha: 1.0))
    }
    
    //Подложка экрана игры -  220 220 220
    func test_gameFieldBackground() {
        XCTAssertEqual(ColorsOfApplication.gameFieldBackground, UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0))
    }
    
    //Черты игрового поля - 150 150 150
    func test_gameFiledLines() {
        XCTAssertEqual(ColorsOfApplication.gameFieldLines, UIColor.init(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1.0))
    }
    
    //Крестик - 90 90 90
    func test_xMarkColor() {
        XCTAssertEqual(ColorsOfApplication.xMarkColor, UIColor.init(red: 90 / 255.0, green: 90 / 255.0, blue: 90 / 255.0, alpha: 1.0))
    }
    
    //Нолик - белый
    func test_oMarkColor() {
        XCTAssertEqual(ColorsOfApplication.oMarkColor, UIColor.white)
    }
}
