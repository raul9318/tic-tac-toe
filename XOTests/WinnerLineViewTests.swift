//
//  WinnerLineViewTests.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 16.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import XCTest
@testable import XO

class WinnerLineViewTests: XCTestCase {
    var sut: WinnerLineView!
    
    override func setUp() {
        super.setUp()
        
        let frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        sut = WinnerLineView(frame: frame, winnerLine: .Horizon(0))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // тэг равен 111
    func test_tag_equal_111() {
        XCTAssertEqual(sut.tag, 111)
    }
    
    // отступы для рисовать должны быть 10
    func test_initially_padding_equal10() {
        XCTAssertEqual(sut.padding, 10)
    }
    
    // толщина линии 8
    func test_initially_lineWidth_equal8() {
        XCTAssertEqual(sut.lineWidth, 8)
    }
    
    // цвет линии черный
    func test_initially_lineColor_isBlack() {
        XCTAssertEqual(sut.lineColor, UIColor.black)
    }
    
    // длительность анимации 0.3
    func test_initially_animationDuration_equal_0dot3() {
        XCTAssertEqual(sut.animationDuration, 0.3)
    }
    
    // полсе инициализации view background прозрачный
    func test_afterInit_viewBackrgoundColor_isClear() {
        XCTAssertEqual(sut.backgroundColor, UIColor.clear)
    }
    
    // имеется слой для рисования линии (CAShapeLayer)
    func test_hasLineLayer_CAShapeLayer() {
        XCTAssertNotNil(sut.lineLayer)
    }
    
    // после инициализации слой рисования имеет path
    func test_afterInit_lineLayerPath_notNil() {
        XCTAssertNotNil(sut.lineLayer.path)
    }
    
    // имеется выигрышная линия
    func test_hasWinnerLine() {
        XCTAssertNotNil(sut.winnerLine)
    }
    
    // возвращается правильная выигрышная линия
    func test_returnWinnerLine() {
        XCTAssertEqual(sut.winnerLine, WinnerLine.Horizon(0))
    }
    
    // размер игрового поля 3x3 
    func test_gameFieldGrid_3x3() {
        XCTAssertEqual(sut.gameFieldGrid, 3)
    }
    
    // начальная и конечная точка рисования при выигрышной первой горизонтальной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_firstHorizon() {
        
        let winnerLine = WinnerLine.Horizon(0)
        let startPoint = CGPoint(x: 10, y: 50)
        let endPoint = CGPoint(x: 290, y: 50)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной второй горизонтальной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_secondtHorizon() {
        
        let winnerLine = WinnerLine.Horizon(1)
        let startPoint = CGPoint(x: 10, y: 150)
        let endPoint = CGPoint(x: 290, y: 150)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной третей горизонтальной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_thirdtHorizon() {
        
        let winnerLine = WinnerLine.Horizon(2)
        let startPoint = CGPoint(x: 10, y: 250)
        let endPoint = CGPoint(x: 290, y: 250)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной первой вертикальной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_firstVertival() {
        
        let winnerLine = WinnerLine.Vertical(0)
        let startPoint = CGPoint(x: 50, y: 10)
        let endPoint = CGPoint(x: 50, y: 290)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной второй вертикальной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_secondVertival() {
        
        let winnerLine = WinnerLine.Vertical(1)
        let startPoint = CGPoint(x: 150, y: 10)
        let endPoint = CGPoint(x: 150, y: 290)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной третей вертикальной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_thirdVertival() {
        
        let winnerLine = WinnerLine.Vertical(2)
        let startPoint = CGPoint(x: 250, y: 10)
        let endPoint = CGPoint(x: 250, y: 290)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной главной диагональной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_mainDiagonal() {
        
        let winnerLine = WinnerLine.Diagonal(0)
        let startPoint = CGPoint(x: 10, y: 10)
        let endPoint = CGPoint(x: 290, y: 290)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
    // начальная и конечная точка рисования при выигрышной второй диагональной линии
    func test_returnStartAndEndPointOfLine_whenWinnerLineIs_secondDiagonal() {
        
        let winnerLine = WinnerLine.Diagonal(1)
        let startPoint = CGPoint(x: 290, y: 10)
        let endPoint = CGPoint(x: 10, y: 290)
        
        testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: 300, winnerLine: winnerLine, startPoint: startPoint, endPoint: endPoint)
    }
    
}

extension WinnerLineViewTests {
    fileprivate func testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: CGFloat, winnerLine: WinnerLine, startPoint: CGPoint, endPoint: CGPoint, line: UInt = #line) {
        
        let frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameWidth)
        let sut = WinnerLineView(frame: frame, winnerLine: winnerLine)
        
        XCTAssertNotNil(sut.startPoint, "Line: \(line)")
        XCTAssertNotNil(sut.endPoint, "Line: \(line)")
        
        XCTAssertEqual(sut.startPoint, startPoint, "Line: \(line)")
        XCTAssertEqual(sut.endPoint, endPoint, "Line: \(line)")
    }
}
