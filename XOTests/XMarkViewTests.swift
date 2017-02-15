//
//  XMarkViewTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 03.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class XMarkViewTests: XCTestCase {
    var sut: XMarkView!
    var fakeCellBounds: CGRect!
    
    override func setUp() {
        super.setUp()
        
        fakeCellBounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        sut = XMarkView.xMarkView(withFrame: fakeCellBounds)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // рамка отображения границе ячейки игрового поля
    func test_frame() {
        XCTAssertEqual(sut.frame, fakeCellBounds)
    }
    
    // TODO толщина линии
    func test_lineWidth_equal3() {
        XCTAssertEqual(sut.lineWidth, 5)
    }
    
    // процентный отступ от границ ячейки
    func test_marginPercentFromFrame() {
        XCTAssertEqual(sut.marginPercentFromFrame, 20)
    }
    
    // отступ в пикселях 
    func test_marginFromFrame() {
        let sut = XMarkView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        XCTAssertEqual(sut.marginFromFrame, 40)
    }
    
    // TODO точки
    func test_points() {
        let sut = XMarkView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        let lt = CGPoint(x: 40, y: 40)
        let lb = CGPoint(x: 40, y: 160)
        let rt = CGPoint(x: 160, y: 40)
        let rb = CGPoint(x: 160, y: 160)
        
        XCTAssertEqual(sut.leftTopPoint, lt)
        XCTAssertEqual(sut.leftBottomPoint, lb)
        XCTAssertEqual(sut.rightTopPoint, rt)
        XCTAssertEqual(sut.rightBottomPoint, rb)
    }
    
    // TODO: рисуется X
}

// MARK: Mock
extension XMarkViewTests {
    
    class MockXMarkView: XMarkView {
        class func mockXMarkView(withFrame frame: CGRect) -> MockXMarkView {
            return MockXMarkView(frame: frame)
        }
    }
    
    class MockLinePath: UIBezierPath {
        var lineCount = 0
        var currentLine: (CGPoint?, CGPoint?)
        var lines = [(CGPoint?, CGPoint?)]()
        
        override func move(to point: CGPoint) {
            currentLine.0 = point
        }
        
        override func addLine(to point: CGPoint) {
            currentLine.1 = point
        }
        
        override func stroke() {
            lines.append(currentLine)
            lineCount += 1
            
            currentLine.0 = nil
            currentLine.1 = nil
        }
    }
    
    
}
