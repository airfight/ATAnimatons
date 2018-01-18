//
//  GYSlider.swift
//  ATAnimatons
//
//  Created by ZGY on 2018/1/18.
//Copyright © 2018年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2018/1/18  下午1:30
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class GYSlider: UISlider {

    private var frameSlider:CGRect!
    private var leftLb:UILabel = {
        let lb = UILabel()
        return lb
    }()
    private var rightLb:UILabel = {
        let lb = UILabel()
        return lb
    }()
    private var topLb:UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        var count: UInt32 = 0
        // 1.2.获取变量的指针
        let outCount: UnsafeMutablePointer<UInt32> = withUnsafeMutablePointer(to: &count) { (outCount: UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<UInt32> in
            return outCount
        }
        // 1.3.获取属性数组
        let ivars = class_copyIvarList(UISlider.self, outCount)
            //
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let ivarKey = String.init(cString: ivar_getName(ivar)!)
            
            print(ivarKey)
            
        }
        free(ivars)
        initUI()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.trackRect(forBounds: bounds)
        frameSlider = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height + 5)
        return bounds
    }

    private func initUI() {
        minimumTrackTintColor = UIColor.clear
        setMinimumTrackImage(colorCreateImage(UIColor.clear), for: UIControlState.normal)
        setMaximumTrackImage(colorCreateImage(UIColor.clear), for: UIControlState.normal)
        setThumbImage(UIImage.init(named: "yuan-1"), for: UIControlState.normal)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.init(hex: "0x9400D3").cgColor,
            UIColor.init(hex: "0x00B2EE").cgColor,
            UIColor.init(hex: "0x98FB98").cgColor,
            UIColor.init(hex: "0xFFEC8B").cgColor,
            UIColor.init(hex: "0xFF6347").cgColor
            ]
        gradientLayer.locations = [(0.1),(0.3),(0.5),(0.7),(1)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = frameSlider
        gradientLayer.cornerRadius = 2.5
        gradientLayer.masksToBounds = true
        layer.addSublayer(gradientLayer)
        self.addTarget(self, action:  #selector(sliderValueChanged(_:)), for: UIControlEvents.valueChanged)
        leftLb.frame = CGRect(x: 0, y: self.bounds.maxY - 20, width: 100, height: 20)
        leftLb.adjustsFontSizeToFitWidth = true
        leftLb.text = "70℃"
        self.addSubview(leftLb)
        
        rightLb.frame = CGRect(x: self.bounds.maxX - 100, y: self.bounds.maxY - 20, width: 100, height: 20)
        rightLb.adjustsFontSizeToFitWidth = true
        rightLb.textAlignment = .right
        rightLb.text = "90℃"
        self.addSubview(rightLb)
        
        topLb.frame = CGRect(x: 0, y: self.bounds.minY + 5, width: 50, height: 20)
        topLb.adjustsFontSizeToFitWidth = true
        topLb.textAlignment = .left
        topLb.text = "0℃"
        self.addSubview(topLb)
        
        addObserver(self, forKeyPath: "value", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        
        let rect = self.thumbRect(forBounds: self.bounds, trackRect: self.bounds, value: self.value)
        topLb.frame = CGRect(x: rect.origin.x - 10, y: self.bounds.minY + 5, width: rect.width + 20, height: 20)
        topLb.textAlignment = .center

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "value" {
            print(1)
        }
        
    }
    
    private func colorCreateImage(_ color:UIColor) -> UIImage?{
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }

}
