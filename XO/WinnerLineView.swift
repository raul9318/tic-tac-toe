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
    let lineColor = UIColor.black
    let animationDuration: TimeInterval = 0.3
    let gameFieldGrid = 3
 
    var winnerLine: WinnerLine!
    var linePath: UIBezierPath!
    var lineLayer: CAShapeLayer!
    var lineLayerAnimation: CABasicAnimation!
    
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
    
    convenience init(frame: CGRect, winnerLine: WinnerLine) {
        self.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        self.winnerLine = winnerLine
        
        setupLineLayer()
        
        layer.addSublayer(lineLayer)
        
        // TODO test
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (time) in
            DispatchQueue.main.async {
                self.animateLine()
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
        if lineLayerAnimation == nil {
            lineLayerAnimation = CABasicAnimation(keyPath: "strokeEnd")
        }
        
        lineLayerAnimation.fromValue = 0
        lineLayerAnimation.toValue = 1
        lineLayerAnimation.duration = animationDuration
        lineLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        lineLayer.strokeEnd = 1.0
        
        lineLayer.add(lineLayerAnimation, forKey: "strokeEnd")
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
