//
//  GYWaveView.swift
//  ATAnimatons
//
//  Created by ZGY on 2017/10/23.
//Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/10/23  下午2:49
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class GYWaveView: UIView {
    
    var waveColors:[UIColor] = []
    var bgColor:UIColor = UIColor.red
    lazy var waveDisplaylink = CADisplayLink()
//    lazy var waveLayer = CAShapeLayer()

    /// 基础描述 正弦函数
    ///   y=Asin(ωx+φ）+ b
    ///   A : wavaA
    ///   w : 1/waveW
    ///   φ : offsetφ
    ///   b : b
    private var waveA: CGFloat = 0
    private var waveW: CGFloat = 0
    private var offsetX: CGFloat = 0
    private var b : CGFloat = 0
    
    //水纹的移动的速度
    var waveSpeed : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initData()
        initUI()
    }
    
    fileprivate func initData() {
        
        waveA = 0.05
        waveA = 6
        
        waveW = 2 * CGFloat.pi / bounds.width
        b = bounds.height / 2
        
    }
    
    fileprivate func initUI() {
        
        waveDisplaylink = CADisplayLink(target: self, selector:#selector(displayAction))
        waveDisplaylink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    @objc func displayAction() {

        offsetX += waveSpeed
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        /// 背景颜色 绘制
        let path = UIBezierPath.init(rect: bounds)

        bgColor.setFill()
        path.fill()
        path.addClip()
        
        if waveColors.count <= 0 {
            return
        }
        
        (waveColors as NSArray).enumerateObjects { (color, index:Int, _) in
            
            let colorW:UIColor = color as! UIColor
            
            createUI(colorW, index: index)
            
        }
        
        
    }
    
    fileprivate func createUI(_ color:UIColor,index:Int) {
        
        let wavelayer = CAShapeLayer()
        wavelayer.fillColor = color.cgColor
        layer.addSublayer(wavelayer)
        
        let path = CGMutablePath()
        var Y = bounds.width / 2
        path.move(to: CGPoint(x: 0, y: Y))
        for i in 0...Int(bounds.width) {
            Y = waveA * sin(waveW * CGFloat(i) + offsetX) + b
            path.addLine(to: CGPoint(x: CGFloat(i), y: Y))
        }
        
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        path.closeSubpath()
        wavelayer.path = path
        
    }
    
    deinit {
        
        waveDisplaylink.invalidate()
        
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
