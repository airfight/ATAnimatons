//
//  InstrumentView.swift
//  ATAnimatons
//
//  Created by ZGY on 2018/1/16.
//Copyright © 2018年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2018/1/16  上午10:26
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class InstrumentView: UIView {

    private var progressLayer:CAShapeLayer?
    private var colorsLayer:CAGradientLayer?
    private var startAngle = CGFloat.pi * 0.75
    private var endAngle = CGFloat.pi * 2.25
    internal var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var radius:CGFloat = 0.0
    private var widthA:CGFloat = 0.0
    private var heightA:CGFloat = 0.0
    private var sumAngle = CGFloat.pi * 1.5
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        drawLayer()        radius = self.frame.width/2 - 20
        radius = self.frame.width/2
        centerPoint = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)

        widthA = self.frame.width / 2
        heightA = self.frame.width / 2

        self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLayer()
        drawPointer()

    }
    
    fileprivate func drawPointer() {
        
//        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: radius * 0.6, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
//        UIColor.white.setFill()
//        path.fill()
//        path.close()
        
//        let context = UIGraphicsGetCurrentContext() //获取上下文
//        context?.saveGState()
//        context?.setAllowsAntialiasing(true)
//        context?.addArc(center: CGPoint(x: 0, y: 0), radius: radius * 0.6, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//        context?.drawPath(using: CGPathDrawingMode.fill)
//        context?.setLineWidth(4)
//        context?.setStrokeColor(UIColor.white.cgColor)
//        context?.strokePath()
//        context?.restoreGState()
        
    }
    
    fileprivate func drawLayer() {
        
        
//        progressLayer = CAShapeLayer()
//        progressLayer?.frame = self.bounds
//
//        let bPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: self.frame.width / 2 - 20, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//
//        progressLayer?.path = bPath.cgPath
//        progressLayer?.fillColor = UIColor.clear.cgColor
//        progressLayer?.lineCap = kCALineCapRound
//        progressLayer?.strokeColor = UIColor.white.cgColor
//        progressLayer?.lineCap = kCAFillRuleEvenOdd
//        progressLayer?.lineJoin = kCALineCapRound
//        progressLayer?.lineDashPattern = [4,15]
//        progressLayer?.lineWidth = 20
//        progressLayer?.miterLimit = 1

//        stride(from: startAngle, to: endAngle, by: CGFloat.pi * 0.02).forEach {
//            angle in
//
//            var transform  = CGAffineTransform(rotationAngle: angle)
//                .concatenating(CGAffineTransform(translationX: 10, y:  20))
//
//            let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100),
//                               transform: &transform)
//
//            bPath.addPath(petal)
//        }

    
//        let path = UIBezierPath(arcCenter:CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: self.frame.width/2 - 20, startAngle: startAngle , endAngle: endAngle , clockwise: true)
//
//        colorsLayer = CAGradientLayer()
//        colorsLayer?.shadowPath = path.cgPath
//        colorsLayer?.frame = self.bounds
//        colorsLayer?.startPoint = CGPoint(x: 0, y: 0.5)
//        colorsLayer?.endPoint = CGPoint(x: 1, y: 0)
//        colorsLayer?.colors = [
//            UIColor(displayP3Red: 9.0/255, green: 142.0/255, blue: 254.0/255, alpha: 1.0).cgColor,
//            UIColor(displayP3Red: 134.0/255, green: 102.0/255, blue: 255.0/255, alpha: 1.0).cgColor,
//            UIColor(displayP3Red: 215.0/255, green: 67.0/255, blue: 113.0/255, alpha: 1.0).cgColor
//        ]
//
//
//        colorsLayer?.mask = progressLayer
////        self.layer.addSublayer(colorsLayer!)
        //线宽,线与线之间的间距
//        let pattern: [CGFloat] = [4,20,8]
//        bPath.setLineDash(pattern ,count: 3, phase: 0)
//        UIColor.red.setStroke()
//        //线长
//        bPath.lineWidth = 20
//        bPath.stroke()
        
        
        let context = UIGraphicsGetCurrentContext() //获取上下文
        
        context?.translateBy(x: self.bounds.midX, y: self.bounds.midY)

        let sumNum = Int(sumAngle / (CGFloat.pi * 0.03))
        let colors = Colors.getMuatbleColors()
        
        for i in 0...sumNum {
            if i == 0 {
                context?.rotate(by: (CGFloat.pi * 45 / 180))
            } else {
                context?.rotate(by: (CGFloat.pi * 0.03))
            }
            
            if i%2 == 1 {
                context?.saveGState()
                context?.addLines(between: [CGPoint(x: 0, y: radius * 0.75),CGPoint(x: 0, y: radius * 0.75 + 15 )])
                context?.setStrokeColor(colors[sumNum - i].cgColor)
                context?.setLineWidth(4)
                context?.setLineCap(CGLineCap.butt)
                context?.strokePath()
                context?.restoreGState()
                
            } else {
                context?.saveGState()
                context?.addLines(between: [CGPoint(x: 0, y: radius * 0.75),CGPoint(x: 0, y: radius * 0.75 + 25 )])
                context?.setStrokeColor(colors[sumNum - i].cgColor)
                context?.setLineWidth(4)
                context?.setLineCap(CGLineCap.butt)
                context?.strokePath()
                context?.restoreGState()
            }

        }
        
        context?.translateBy(x: 0, y: 0)
//        context?.saveGState()
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: radius * 0.6, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        context?.addPath(path.cgPath)
        path.addLine(to: CGPoint(x: -radius * 0.3, y: radius * 0.2))
        path.addLine(to: CGPoint(x: -radius * 0.55, y: radius * 0.55))
        context?.rotate(by: (CGFloat.pi * 45 / 180))
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.white.cgColor)
        path.fill()
        context?.strokePath()
//        context?.restoreGState()
 
//        let context1 = UIGraphicsGetCurrentContext() //获取上下文
//        context?.saveGState()
//        context?.setAllowsAntialiasing(true)
//        context?.addArc(center: centerPoint, radius: radius * 0.6, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//        context?.drawPath(using: CGPathDrawingMode.fill)
//        context?.setLineWidth(4)
//        context?.setStrokeColor(UIColor.white.cgColor)
//        context?.strokePath()
//        context?.restoreGState()
        
       /*
        context?.clip()
        let rgb = CGColorSpaceCreateDeviceRGB()
        let colors:[CGFloat] = [204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
                                29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
                                0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00]
        
        
        let gradient = CGGradient(colorSpace: rgb, colorComponents: colors, locations: [0,0.3,0.5,0.8,1.0], count: 4)
        
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: 1), options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        */

//        context?.setLineWidth(4)
//        context?.setLineCap(CGLineCap.butt)
//        context?.strokePath()
//        context?.restoreGState()


//        let path = UIBezierPath(arcCenter:CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: self.frame.width/2 - 20, startAngle: startAngle , endAngle: endAngle , clockwise: true)
//
//        colorsLayer = CAGradientLayer()
//        colorsLayer?.shadowPath = path.cgPath
//        colorsLayer?.locations = [0,0.5,1]
//
//        colorsLayer?.frame = self.bounds
//        colorsLayer?.startPoint = CGPoint(x: 0, y: 0.5)
//        colorsLayer?.endPoint = CGPoint(x: 1, y: 0)
//        colorsLayer?.colors = [
//            UIColor(displayP3Red: 9.0/255, green: 142.0/255, blue: 254.0/255, alpha: 1.0).cgColor,
//            UIColor(displayP3Red: 134.0/255, green: 102.0/255, blue: 255.0/255, alpha: 1.0).cgColor,
//            UIColor(displayP3Red: 215.0/255, green: 67.0/255, blue: 113.0/255, alpha: 1.0).cgColor
//        ]
//        let shal = CAShapeLayer()
//        shal.path = path.cgPath
//        shal.fillColor = UIColor.white.cgColor
//        colorsLayer?.mask = shal
//        self.layer.addSublayer(colorsLayer!)

        /* UIBezierPath + Layer实现
        
        let bPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: self.frame.width / 2 - 20, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        //线宽,线与线之间的间距
        let pattern: [CGFloat] = [4,20]
        bPath.setLineDash(pattern ,count: 2, phase: 0)
        UIColor.white.setStroke()/
        //线长
        bPath.lineWidth = 20
        bPath.stroke()
        
        let path = UIBezierPath(arcCenter:CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: self.frame.width/2 - 20, startAngle: startAngle , endAngle: endAngle , clockwise: true)
        
        let pattern2:[CGFloat] = [4,8]
        path.setLineDash(pattern2 ,count: 2, phase: 0)
        UIColor.white.setStroke()
        
        //线长
        path.lineWidth = 15
        path.stroke()
        
        colorsLayer = CAGradientLayer()
        colorsLayer?.frame = self.bounds
        colorsLayer?.colors = [
            UIColor(displayP3Red: 9.0/255, green: 142.0/255, blue: 254.0/255, alpha: 1.0).cgColor,
            UIColor(displayP3Red: 134.0/255, green: 102.0/255, blue: 255.0/255, alpha: 1.0).cgColor,
            UIColor(displayP3Red: 215.0/255, green: 67.0/255, blue: 113.0/255, alpha: 1.0).cgColor
        ]
        
        colorsLayer?.shadowPath = bPath.cgPath
        let shal = CAShapeLayer()
        shal.path = bPath.cgPath
//        shal.fillColor = UIColor.clear.cgColor
        colorsLayer?.frame = self.bounds
        colorsLayer?.mask = shal
        self.layer.addSublayer(colorsLayer!)

        */
    }
    
    

}
