//
//  OMarkView.swift
//  XO
//
//  Created by Рамиль Ибрагимов on 03.02.17.
//  Copyright © 2017 Рамиль Ибрагимов. All rights reserved.
//

import UIKit

@IBDesignable
class OMarkView: UIView {

    let marginPercentFromCellFrame: CGFloat = 20
    
    lazy var marginFromCellFrame: CGFloat = {
        return self.bounds.width / 100 * self.marginPercentFromCellFrame
    }()
 
    lazy var radiusOfCircle: CGFloat = {
        let width = self.bounds.width
        return (width - self.marginFromCellFrame * 2) / 2
    }()
    
    lazy var centerOfCircle: CGPoint = {
        return self.center
    }()
    
    let lineWidth: CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 100, green: 0, blue: 0, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawCircle()
    }
    
    func drawCircle(){
        let circlePath = UIBezierPath(arcCenter: self.centerOfCircle, radius: self.radiusOfCircle, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: false)
        
        circlePath.lineWidth = lineWidth
        
        circlePath.stroke()
    }
}
