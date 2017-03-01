//
//  WinnerLineView.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 16.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

class WinnerLineView: UIView {
    let padding: CGFloat = 10
    let lineWidth: CGFloat = 8
    var lineColor = UIColor.black
    let animationDuration: TimeInterval = 0.3
    let animationDelay: TimeInterval = 0.6
    let gameFieldGrid = 3
 
    var winnerLine: WinnerLine!
    var linePath: UIBezierPath!
    var lineLayer: CAShapeLayer!
    lazy var lineLayerAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
    
    lazy var startPoint: CGPoint! = {
        return self.calculateStartPoint()
    }()
    lazy var endPoint: CGPoint! = {
        return self.calculateEndPoint()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tag = 111
    }
    
    convenience init(frame: CGRect, gameEngine: GameEngine) {
        self.init(frame: frame)
        
        if let winner = gameEngine.winner {
            switch winner {
            case .X:
                lineColor = ColorsOfApplication.xMarkColor
            case .O:
                lineColor = ColorsOfApplication.oMarkColor
            }
        }
        
        backgroundColor = UIColor.clear
        
        self.winnerLine = gameEngine.winnerLine
        
        setupLineLayer()
        
        layer.addSublayer(lineLayer)
        
        // TODO test
        self.animateLine()
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (time) in
            DispatchQueue.main.async {
                
            }
        }
    }
    
    func setupLineLayer() {
        if linePath == nil {
            linePath = UIBezierPath()
        }
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        if lineLayer == nil {
            lineLayer = CAShapeLayer()
        }
        
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = lineWidth
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.strokeEnd = 0.0
    }
    
    func animateLine() {
        let allAnimationDuration = animationDelay + animationDuration
        
        lineLayerAnimation.keyTimes = [0, NSNumber(value: animationDelay / allAnimationDuration), 1]
        lineLayerAnimation.values = [0.0, 0.0, 1.0]
        
        lineLayerAnimation.duration = allAnimationDuration
        lineLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        lineLayer.add(lineLayerAnimation, forKey: "strokeEnd")
        
        lineLayer.strokeEnd = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func calculateStartPoint() -> CGPoint {
        let viewWidth = bounds.width
        
        let oneCellWidth = viewWidth / 3
        let middleCellWidth = oneCellWidth / 2
        
        var x: CGFloat!
        var y: CGFloat!
        
        let winnerLine: WinnerLine = self.winnerLine
        
        switch winnerLine {
        case WinnerLine.Horizon(let line):
            x = padding
            y = oneCellWidth * CGFloat(line + 1) - middleCellWidth
            break
        case WinnerLine.Vertical(let line):
            x = oneCellWidth * CGFloat(line + 1) - middleCellWidth
            y = padding
            break
        case WinnerLine.Diagonal(0):
            x = padding
            y = padding
            break
        case WinnerLine.Diagonal(1):
            x = viewWidth - padding
            y = padding
            break
        default:
            fatalError()
            break
        }
        
        
        return CGPoint(x: x, y: y)
    }
    
    func calculateEndPoint() -> CGPoint {
        let viewHeight = bounds.height
        
        let oneCellWidth = viewHeight / 3
        let middleCellWidth = oneCellWidth / 2
        
        var x: CGFloat!
        var y: CGFloat!
        
        let winnerLine: WinnerLine = self.winnerLine
        
        switch winnerLine {
        case WinnerLine.Horizon(let line):
            x = viewHeight - padding
            y = oneCellWidth * CGFloat(line + 1) - middleCellWidth
            break
        case WinnerLine.Vertical(let line):
            x = oneCellWidth * CGFloat(line + 1) - middleCellWidth
            y = viewHeight - padding
        case WinnerLine.Diagonal(0):
            x = viewHeight - padding
            y = viewHeight - padding
            break
        case WinnerLine.Diagonal(1):
            x = padding
            y = viewHeight - padding
            break
        default:
            fatalError()
            break
        }
        
        
        return CGPoint(x: x, y: y)
    }
}
