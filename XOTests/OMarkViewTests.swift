//
//  OMarkViewTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 03.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class OMarkViewTests: XCTestCase {
    var sut: OMarkView!
    
    override func setUp() {
        super.setUp()
        let fakeCellBounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        sut = OMarkView(frame: fakeCellBounds)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // отступ в процентах от границ ячейки
    func test_marginPercentFromCellFrame() {
        XCTAssertEqual(sut.marginPercentFromCellFrame, 20)
    }
    
    // отступ в пикселях от границ ячейки
    func test_marginFromCellFrame() {
        XCTAssertEqual(sut.marginFromCellFrame, 40)
    }
    
    // радиус окружности
    func test_radiusOfCircle() {
        XCTAssertEqual(sut.radiusOfCircle, 60)
    }

    // центра окружности = центр отображения
    func test_centerOfCircle() {
        XCTAssertEqual(sut.center, sut.centerOfCircle)
    }
    
    // толщина линии
    func test_lineWidth_equal3() {
        XCTAssertEqual(sut.lineWidth, 5)
    }
    
    // цвет линии 
    func test_lineColor() {
        XCTAssertEqual(sut.lineColor, UIColor.white)
    }
    
    
}
