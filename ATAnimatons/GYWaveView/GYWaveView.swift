//
//  GYWaveView.swift
//  ATAnimatons
//
//  Created by ZGY on 2017/10/9.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/10/9  上午10:10
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

enum GYWaveViewType {
    case OvalInRect //圆
    case Rect
}

struct GYWaveViewConfing {
    
    var amplitude:CGFloat = 4
    var cycle:CGFloat = 0
    var distanceH:CGFloat = 0
    var distanceV:CGFloat = 0
    var waveScale:CGFloat = 0
    var progress:CGFloat = 0
    var colors:[UIColor] = []
    var waveType:GYWaveViewType = .Rect
    
}

class GYWaveView: UIView {
    
    var isWaveStart:Bool = false {
        didSet {
            if isWaveStart {
                startWave()
            } else {
                endWave()
            }
        }
    }

    private var waveConfig:GYWaveViewConfing!
    private var bezierPath:UIBezierPath!
    
    private var displayLink:CADisplayLink!
    private var offsetyScale:CGFloat = 1
//    {
//        set {
//            if offsetyScale != newValue {
//                self.offsetyScale = newValue
//            }
//        }
//        get {
//            return self.offsetyScale
//        }
//    }
    
    private var moveWidth:CGFloat = 0.5
    private var offsetY:CGFloat = 0.5
    private var offsetx:CGFloat = 0.5
//    private var path:UIBezierPath!
    
    init(frame: CGRect,config:GYWaveViewConfing?) {
        super.init(frame: frame)
        assert(config != nil, "请初始化配置信息")
        waveConfig = config
        
        if waveConfig.progress > 1 {
            waveConfig.progress = 1
        }
        offsetY = (1 - waveConfig.progress) * (self.frame.size.height + 2 * waveConfig.amplitude)
        offsetyScale = 1
        waveConfig.waveScale = 0.1
        moveWidth = 0.5
        waveConfig.amplitude = 4
        waveConfig.distanceV = waveConfig.amplitude * 0.4
        waveConfig.cycle = 2 * CGFloat.pi / (self.frame.size.width * 0.9);
        waveConfig.distanceH = 2 * CGFloat.pi / waveConfig.cycle * 0.6
        
        if waveConfig != nil {
            bezierPath = (waveConfig.waveType == .OvalInRect) ? UIBezierPath(ovalIn: self.bounds) : UIBezierPath(rect: self.bounds)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //此处可添加背景颜色
        bezierPath.fill()
        bezierPath.addClip()
        
        if let colors = waveConfig?.colors {
            
            (colors as NSArray).enumerateObjects({ (color, index, _) in
              
                drawWave(color as! UIColor, offsetX: waveConfig.distanceH * CGFloat(index) + waveConfig.distanceH, offsetY: waveConfig.distanceV * CGFloat(index) + waveConfig.distanceV)
                
            })
            
        }
        
    }
    
    private func drawWave(_ color:UIColor,offsetX:CGFloat,offsetY:CGFloat) {
        
        //波浪动画
        let endOffY = (1 - waveConfig.progress) * (self.frame.height + 2 * waveConfig.amplitude)
        
        if offsetY != endOffY {
            if endOffY < self.offsetY {
                
                self.offsetY = self.offsetY - (self.offsetY - endOffY) * offsetyScale
                self.offsetY = max(self.offsetY, endOffY)
            } else {
                
                self.offsetY = self.offsetY + (endOffY - self.offsetY) * offsetyScale
                self.offsetY = min(self.offsetY, endOffY)
            }
        }
        
        let wavePath = UIBezierPath()
        
        for nextX in 0...Int(self.frame.width) {
            
            let nextY = waveConfig.amplitude * sin(waveConfig.cycle * CGFloat(nextX) + self.offsetx + offsetx / self.bounds.width * 2 * CGFloat.pi) + self.offsetyScale + offsetY
            
            if nextX == 0 {
                wavePath.move(to: CGPoint(x: CGFloat(nextX), y: nextY - waveConfig.amplitude))
            } else {
                wavePath.addLine(to: CGPoint(x: CGFloat(nextX), y: nextY - waveConfig.amplitude))
            }
        }
        
        wavePath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        wavePath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        color.set()
        wavePath.fill()
    }
    
    func startWave() {
        
        self.backgroundColor = UIColor.clear
        self.displayLink = CADisplayLink.init(target: self, selector: #selector(GYWaveView.displayLinkAction))
        self.displayLink.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    func displayLinkAction() {
        
        self.offsetx = self.offsetx + waveConfig.waveScale
        setNeedsDisplay()
    }
    
    func endWave() {
        
        removeDisplayLinkAction()
    }
    
    fileprivate func removeDisplayLinkAction() {
        displayLink.invalidate()
        displayLink = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
