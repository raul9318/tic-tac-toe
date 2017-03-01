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
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: WinnerLine.Horizon(0), winner: Player.X)
        
        let frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        sut = WinnerLineView(frame: frame, gameEngine: fakeGameEngine)
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
    
    
    // длительность анимации 0.3
    func test_initially_animationDuration_equal_0dot3() {
        XCTAssertEqual(sut.animationDuration, 0.3)
    }
    
    // полсе инициализации view background прозрачный
    func test_afterInit_viewBackrgoundColor_isClear() {
        XCTAssertEqual(sut.backgroundColor, UIColor.clear)
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
    
    // настройка слоя
    // устанавливается начальная и конечная точка
    func test_setupLineLayer() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: WinnerLine.Horizon(0), winner: Player.X)
        
        let sut = WinnerLineView(frame: frame, gameEngine: fakeGameEngine)
        
        let mockLinePath = MockLinePath()
        sut.linePath = mockLinePath
        
        sut.setupLineLayer()
        
        XCTAssertNotNil(mockLinePath.gotStartPoint)
        XCTAssertNotNil(mockLinePath.gotEndPoint)
        
        let startPoint = CGPoint(x: 10, y: 50)
        let endPoint = CGPoint(x: 290, y: 50)
        
        XCTAssertEqual(mockLinePath.gotStartPoint, startPoint)
        XCTAssertEqual(mockLinePath.gotEndPoint, endPoint)
    }
    
    // настройка слоя путь линии является путем слоя рисования
    func test_setupLineLayer_lineLayerPathEqual_linePath() {
        let mockLineLayer = MockLineLayer()
        sut.lineLayer = mockLineLayer
        
        sut.setupLineLayer()
        
        XCTAssertTrue(mockLineLayer.gotCGPath === sut.linePath.cgPath)
    }
    
    // настройка слоя устанавливает толщину линии равную параметру lineWidth
    func test_setupLineLayer_setupLineWidth_equalLineWidthParam() {
        sut.setupLineLayer()
        
        XCTAssertEqual(sut.lineLayer.lineWidth, sut.lineWidth)
    }
    
    // настройка слоя устанавливает цвет линии равную параметру lineColor
    func test_setupLineLayer_setupStrokeColor_equalLineColorParam() {
        sut.setupLineLayer()
        
        XCTAssertEqual(sut.lineLayer.strokeColor, sut.lineColor.cgColor)
    }
    
    // настройка слоя устанавливает прозрачный цвет подложки
    func test_setupLineLayer_setClearBackground() {
        sut.setupLineLayer()
        
        XCTAssertEqual(sut.lineLayer.fillColor, UIColor.clear.cgColor)
    }
    
    // настройка слоя устанавливает strokeEnd в 0.0
    // чтобы не отрисовывалась линия
    func test_setupLineLayer_setStrokeEnd_equal_0_0() {
        sut.setupLineLayer()
        
        XCTAssertEqual(sut.lineLayer.strokeEnd
            , 0.0)
    }
    
    // после инициализации вызывается настройка слоя рисования линии
    func test_init_calledSetupLineLayer() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: WinnerLine.Horizon(0), winner: Player.X)
        
        let sut = MockWinnerLineView(frame: frame, gameEngine: fakeGameEngine)
        
        XCTAssertTrue(sut.gotCalledSetupLineLayer)
    }

    // добавляем слой к слоям отображению после настройки
    func test_addLineLayer_toViewsLayers_afterSetupLineLayer() {
        
        let sublayers = sut.layer.sublayers
        
        guard let result = sublayers?.contains(where: { (layer) -> Bool in
            let lineLayer = self.sut.lineLayer
            return layer === lineLayer
        }) else {
            XCTFail(); return
        }
        
        XCTAssertTrue(result)
    }
    
    // запуск анимации настраиваются параметры анимации
    func test_animateLine_setupAnimationParams() {
        sut.animateLine()
        
        let animation = sut.lineLayerAnimation
        
        XCTAssertEqual(animation.keyPath, "strokeEnd")
        XCTAssertEqual(animation.keyTimes!, [0, NSNumber(value: sut.animationDelay / (sut.animationDelay + sut.animationDuration)) ,1])
        XCTAssertEqual(animation.values as! [Double], [0.0, 0.0, 1])
        XCTAssertEqual(animation.timingFunction, CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
    }
    
    // запуск анимации изменяет параметр strokeEnd у слоя линии
    func test_animateLine_changesLineLayerStrokeEnd_to_1_0() {
        sut.animateLine()
        
        XCTAssertEqual(sut.lineLayer.strokeEnd, 1.0)
    }
    
    // запуск анимации добавляет анимацию с ключом strokeEnd к слою рисования линии
    func test_animateLine_addAnimationWithKeyStrokeEnd_toLineLayer() {
        let mockLineLayer = MockLineLayer()
        sut.lineLayer = mockLineLayer
        
        sut.animateLine()
        
        XCTAssertTrue(mockLineLayer.gotAnimation)
        XCTAssertEqual(mockLineLayer.gotAnimationForKey, "strokeEnd")
    }
    
    // запуск анимации после инициализации
    func test_animateLine_afterInit() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: WinnerLine.Vertical(0), winner: Player.X)
        
        let sut = MockWinnerLineView(frame: frame, gameEngine: fakeGameEngine)
        
        XCTAssertTrue(sut.gotCalledAnimateLine)
    }
    
    // цвет линии если победили крестики
    func test_lineColor_whenWinnerPlayerX() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: WinnerLine.Vertical(0), winner: Player.X)
        
        let sut = WinnerLineView(frame: frame, gameEngine: fakeGameEngine)
        
        XCTAssertEqual(sut.lineColor, ColorsOfApplication.xMarkColor)
    }
    
    // цвет линии если победили нолики
    func test_lineColor_whenWinnerPlayerO() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: WinnerLine.Vertical(0), winner: Player.O)
        
        let sut = WinnerLineView(frame: frame, gameEngine: fakeGameEngine)
        
        XCTAssertEqual(sut.lineColor, ColorsOfApplication.oMarkColor)
    }
}

extension WinnerLineViewTests {
    fileprivate func testing_returnStartAndEndPointOfLine_whenWinnerLineIs(frameWidth: CGFloat, winnerLine: WinnerLine, startPoint: CGPoint, endPoint: CGPoint, line: UInt = #line) {
        
        let frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameWidth)
        let fakeGameEngine = FakeGameEngine.fakeGameEngine(winnerLine: winnerLine, winner: Player.X)
        
        let sut = WinnerLineView(frame: frame, gameEngine: fakeGameEngine)
        
        XCTAssertNotNil(sut.startPoint, "Line: \(line)")
        XCTAssertNotNil(sut.endPoint, "Line: \(line)")
        
        XCTAssertEqual(sut.startPoint, startPoint, "Line: \(line)")
        XCTAssertEqual(sut.endPoint, endPoint, "Line: \(line)")
    }
}

// MARK: - Fake
extension WinnerLineViewTests {
    class FakeGameEngine: GameEngine {
        class func fakeGameEngine(winnerLine: WinnerLine?, winner: Player?) -> FakeGameEngine {
            let f = FakeGameEngine()
            f.winner = winner
            f.winnerLine = winnerLine
            return f
        }
    }
}

// MARK: - Mock
extension WinnerLineViewTests {
    class MockWinnerLineView: WinnerLineView {
        var gotCalledSetupLineLayer = false
        var gotCalledAnimateLine = false
        
        override func setupLineLayer() {
            gotCalledSetupLineLayer = true
            super.setupLineLayer()
        }
        
        override func animateLine() {
            gotCalledAnimateLine = true
            super.animateLine()
        }
    }
    
    class MockLinePath: UIBezierPath {
        var gotStartPoint: CGPoint!
        var gotEndPoint: CGPoint!
        
        override func move(to point: CGPoint) {
            gotStartPoint = point
            super.move(to: point)
        }
        
        override func addLine(to point: CGPoint) {
            gotEndPoint = point
            super.addLine(to: point)
        }
    }
    
    class MockLineLayer: CAShapeLayer {
        var gotCGPath: CGPath!
        var gotAnimation = false
        var gotAnimationForKey: String?
        
        override var path: CGPath? {
            get {
                return super.path
            }
            set {
                self.gotCGPath = newValue
            }
        }
        
        override func add(_ anim: CAAnimation, forKey key: String?) {
            gotAnimation = true
            gotAnimationForKey = key
        }
    }
}
