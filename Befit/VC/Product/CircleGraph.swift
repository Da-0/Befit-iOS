//
//  CircleGraph.swift
//  Befit
//
//  Created by 이충신 on 29/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//
//  Product.Storyboard
//  2) 체크 비교 팝업 뷰 상단 원형 그래프 Class
//  참고 https://www.youtube.com/watch?v=O3ltwjDJaMk

import UIKit

class CircleGraph {
    
    //이니셜라이저 변수
    var parentView: UIImageView?
    var percentage: String?
    var percent: Double?
    
    //두개의 레이어(배경테두리,색상테두리)
    let grayLayer = CAShapeLayer()
    let colorLayer = CAShapeLayer()

    //에니메이션 변수
    let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")

    init(_ parentView: UIImageView, _ percentage: String){
        self.parentView = parentView;
        self.percentage = percentage;
        self.percent = percentage.toDouble()
        
        self.makeCircleLayer()
    }
    
    func makeCircleLayer(){
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 20, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let centerPoint =  CGPoint(x:(parentView?.layer.bounds.midX)!, y: 29)
        
        //1)create loading b.g. layer(color gray)
        grayLayer.path = circularPath.cgPath
        grayLayer.strokeColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        grayLayer.lineWidth = 6
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.lineCap = CAShapeLayerLineCap.square
        grayLayer.position = centerPoint
        parentView?.layer.addSublayer(grayLayer)
        
        //2)create loading layer(color white)
        colorLayer.path = circularPath.cgPath
        colorLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        colorLayer.lineWidth = 6
        colorLayer.fillColor = UIColor.clear.cgColor
        colorLayer.lineCap = CAShapeLayerLineCap.square
        colorLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        colorLayer.position = centerPoint
        
        colorLayer.strokeEnd = 0
        parentView?.layer.addSublayer(colorLayer)

    }
    
    //Animate Effect
    func animateCircle() {
        guard let value = percent else {return}
        circleAnimation.toValue = value/100.0
        circleAnimation.duration = value/100.0
        circleAnimation.fillMode = CAMediaTimingFillMode.forwards
        circleAnimation.isRemovedOnCompletion = false
        
        colorLayer.add(circleAnimation, forKey: "urSoBasic")
    }
    
}


