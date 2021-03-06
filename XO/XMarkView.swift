//
//  XMarkView.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 03.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

@IBDesignable
class XMarkView: UIView {
    let lineWidth: CGFloat = 5
    let lineColor: UIColor = ColorsOfApplication.xMarkColor
    let marginPercentFromFrame: CGFloat = 20
    
    lazy var marginFromFrame: CGFloat = {
        return self.bounds.width / 100.0 * self.marginPercentFromFrame
    }()
    
    lazy var leftTopPoint: CGPoint = {
        CGPoint(x: self.marginFromFrame, y: self.marginFromFrame)
    }()
    lazy var rightBottomPoint: CGPoint = {
        return CGPoint(x: self.bounds.width - self.marginFromFrame, y: self.bounds.height - self.marginFromFrame)
    }()
    lazy var rightTopPoint: CGPoint = {
       return CGPoint(x: self.bounds.width - self.marginFromFrame, y: self.marginFromFrame)
    }()
    
    lazy var leftBottomPoint: CGPoint = {
        return CGPoint(x: self.marginFromFrame, y: self.bounds.height - self.marginFromFrame)
    }()
    
    var firstLineLayer: CAShapeLayer!
    var secondLineLayer: CAShapeLayer!
    
    enum Line: Int {
        case First
        case Second
    }
    
    let allAnimationDuration: TimeInterval = 0.4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        let firstLinePath = UIBezierPath()
        firstLinePath.move(to: leftTopPoint)
        firstLinePath.addLine(to: rightBottomPoint)
        
        firstLineLayer = CAShapeLayer()
        firstLineLayer.path = firstLinePath.cgPath
        firstLineLayer.fillColor = UIColor.clear.cgColor
        firstLineLayer.strokeColor = lineColor.cgColor
        firstLineLayer.lineWidth = lineWidth
        
        firstLineLayer.strokeEnd = 0.0
        
        layer.addSublayer(firstLineLayer)
        
        let secondLinePath = UIBezierPath()
        secondLinePath.move(to: rightTopPoint)
        secondLinePath.addLine(to: leftBottomPoint)
        
        secondLineLayer = CAShapeLayer()
        secondLineLayer.path = secondLinePath.cgPath
        secondLineLayer.fillColor = UIColor.clear.cgColor
        secondLineLayer.strokeColor = lineColor.cgColor
        secondLineLayer.lineWidth = lineWidth
        
        secondLineLayer.strokeEnd = 0.0
        
        layer.addSublayer(secondLineLayer)
        
        animateLine(line: .First)
        animateLine(line: .Second)
    }
    
    func animateLine(line: Line) {

        if line == Line.First {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            
            animation.duration = allAnimationDuration / 2
            
            animation.fromValue = 0
            animation.toValue = 1
            
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            firstLineLayer.strokeEnd = 1.0
            firstLineLayer.add(animation, forKey: "animateLine")
        }

        if line == Line.Second {
            let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
            animation.duration = allAnimationDuration
            
            animation.keyTimes = [0, 0.5, 1]
            animation.values = [
                0, 0, 1.0
            ]
            secondLineLayer.strokeEnd = 1.0
            secondLineLayer.add(animation, forKey: "animateLine")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
