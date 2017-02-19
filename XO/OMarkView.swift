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
    let lineColor: UIColor = ColorsOfApplication.oMarkColor
    
    let durationOfAnimation: TimeInterval = 0.3
    
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // легкий способ создать CGPath
        let startAngle = 7*M_PI/6
        let circlePath = UIBezierPath(arcCenter: centerOfCircle, radius: radiusOfCircle, startAngle: CGFloat(startAngle), endAngle: CGFloat(startAngle - 2*M_PI), clockwise: false)
        
        // настраиваем circleLayer
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = lineColor.cgColor
        circleLayer.lineWidth = lineWidth
        
        // чтобы при инициализации не произошло рисование - указываем параметр strokeEnd = 0.0
        circleLayer.strokeEnd = 0.0
        
        // добавляем слой круга к слоям отображения
        layer.addSublayer(circleLayer)
        
        // запускаем анимацию при инициализации
        animateCurcle()
    }

    func animateCurcle() {
        // мы хотим анимировать параметр strokeEnd слоя круга
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // устанавливаем длительность анимации
        animation.duration = durationOfAnimation
        
        // анимировать будем от 0 (нет круга) до 1 (полный круг)
        animation.fromValue = 0
        animation.toValue = 1
        
        // временная функция анимации
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // устанавливаем свойство strokeEnd для слоя круга
        // то значение в котором должна закончится анимация
        circleLayer.strokeEnd = 1.0
        
        // выполняем анимацию
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
