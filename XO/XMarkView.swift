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
    class func xMarkView(withFrame frame: CGRect) -> XMarkView{
        let xMarkView = XMarkView(frame: frame)
        
        return xMarkView
    }
    
    let lineWidth: CGFloat = 5
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
    
    lazy var leftBottomPoin: CGPoint = {
        return CGPoint(x: self.marginFromFrame, y: self.bounds.height - self.marginFromFrame)
    }()
    
    var linePath: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 100, green: 0, blue: 0, alpha: 0)
        linePath = UIBezierPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func draw(_ rect: CGRect) {
        drawLine(start: leftTopPoint, end: rightBottomPoint)
        drawLine(start: leftBottomPoin, end: rightTopPoint)
    }
    
    func drawLine(start: CGPoint, end: CGPoint) {
        if let linePath = linePath {
            linePath.move(to: start)
            linePath.addLine(to: end)
            linePath.lineWidth = lineWidth
            
            linePath.stroke()
        }
    }
}
