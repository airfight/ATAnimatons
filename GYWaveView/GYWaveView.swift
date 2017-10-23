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
    var bgColor:UIColor = UIColor.clear
    lazy var waveDisplaylink = CADisplayLink()
    lazy var waveLayer = CAShapeLayer()
    
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
        let path = UIBezierPath()
        
        bgColor.setFill()
        path.fill()
        path.addClip()
        
        
        
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
