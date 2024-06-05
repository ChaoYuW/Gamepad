//
//  HandleItem.swift
//  Gamepad
//
//  Created by chao on 2024/6/5.
//

import UIKit
import SwiftUI

class HandleItem: UIView {

    var centerX : CGFloat = 100;
    var centerY : CGFloat = 100;
    var width = 168.0
    var height = 168.0
    var itemLayers: NSMutableArray = []
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = CGRectGetWidth(self.frame)
        let height = CGRectGetHeight(self.frame)
        self.width = width
        self.height = height
        
        self.centerX = width*0.5
        self.centerY = height*0.5
        
//        self.backgroundColor = UIColor.orange
        
        
    }

    
    override func draw(_ rect: CGRect) {
        
        self.itemLayers.forEach { item in
        
            (item as! CAShapeLayer).removeFromSuperlayer()
        }
        self.itemLayers.removeAllObjects()
        
        self.topItem()
        self.rightItem()
        self.bottomItem()
        self.leftItem()
        
        
        self.blank()
    }
    
    func blank(){
        let centerX = self.centerX
        let centerY = self.centerY
        
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
        layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
        //半径
        let radius :CGFloat = self.width*0.5*0.4
        //按照顺时针方向
        let clockWise = true;
        let path = UIBezierPath(arcCenter:CGPointMake(centerX, centerY), radius:radius,
                startAngle: 0, endAngle: 2*Double.pi, clockwise: clockWise)
        path.close()
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        
    }
    
   func topItem(){
       let centerX = self.centerX
       let centerY = self.centerY
       let width = self.width*0.5
       
       let startAngle:CGFloat = 225.0*Double.pi/180.0
       let endAngle:CGFloat = 315.0*Double.pi/180.0
       
       let layer = CAShapeLayer()
       layer.lineWidth = 1
       layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
       layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
    
       let path = UIBezierPath()
       path.move(to: CGPointMake(centerX, centerY))
       path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
       path.close()
       layer.path = path.cgPath
       self.layer.addSublayer(layer)
       
       self.itemLayers.add(layer)
       
       
       
    }
    func rightItem(){
        let centerX = self.centerX
        let centerY = self.centerY
        let width = self.width*0.5
        
        let startAngle:CGFloat = 315.0*Double.pi/180.0
        let endAngle:CGFloat = 45.0*Double.pi/180.0
        
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
        layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
//        layer.fillColor = UIColor.white.cgColor
        let path = UIBezierPath()
        path.move(to: CGPointMake(centerX, centerY))
        path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        
        self.itemLayers.add(layer)
     }
    func bottomItem(){
        let centerX = self.centerX
        let centerY = self.centerY
        let width = self.width*0.5
        
        let startAngle:CGFloat = 45.0*Double.pi/180.0
        let endAngle:CGFloat = 135.0*Double.pi/180.0
        
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
        layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
//        layer.fillColor = UIColor.white.cgColor
        let path = UIBezierPath()
        path.move(to: CGPointMake(centerX, centerY))
        path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        
        self.itemLayers.add(layer)
     }
    func leftItem(){
        let centerX = self.centerX
        let centerY = self.centerY
        let width = self.width*0.5
        
        let startAngle:CGFloat = 135.0*Double.pi/180.0
        let endAngle:CGFloat = 225.0*Double.pi/180.0
        
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
        layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
//        layer.fillColor = UIColor.white.cgColor
        let path = UIBezierPath()
        path.move(to: CGPointMake(centerX, centerY))
        path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        
        self.itemLayers.add(layer)
        
     }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point = touches.first!.location(in: self)
        
//        let layer = self.getCurrentSelectedOneTouch(point: point)
//        layer?.fillColor = UIColor.white.cgColor
        
        for item in self.itemLayers{
            let layer:CAShapeLayer = item as! CAShapeLayer
            if(layer.path != nil && layer.path!.contains(point)){
                layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#0383FF").cgColor
            }else{
                layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        for item in self.itemLayers{
            let layer:CAShapeLayer = item as! CAShapeLayer
            layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
        }
    }
    
    
    func getCurrentSelectedOneTouch(point:CGPoint) -> CAShapeLayer?{
        
        for item in self.itemLayers{
            let layer:CAShapeLayer = item as! CAShapeLayer
            if(layer.path != nil && layer.path!.contains(point)){
                return layer
            }
        }
        
//        self.itemLayers.forEach({ item in
//            let layer:CAShapeLayer = item as! CAShapeLayer
//            if(layer.path != nil && layer.path!.contains(point)){
//                return layer
//            }
//        })
        return nil
    }
    //自定义通过圆心、弧度、半径获取目标点CGPoint
    func getPoint(center:CGPoint,angle:CGFloat,radius:CGFloat) -> CGPoint{
        let x = center.x + cos(angle) * radius
        let y = center.y + sin(angle) * radius
        return CGPoint(x: x, y: y)
    }
}
