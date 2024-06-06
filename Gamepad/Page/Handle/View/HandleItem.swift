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
    
    
//    var arrow : UILabel {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        label.text = ">"
//        label.textColor = UIColor.white
//        return label
//    }
    
    
    
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
       
       self.drawItem(startAngle: 225.0, endAngle: 315.0,centerAngle: 270.0)
       
    }
    func rightItem(){
        
        self.drawItem(startAngle: 315.0, endAngle: 45,centerAngle: 0.0)
        
     }
    func bottomItem(){
        self.drawItem(startAngle: 45.0, endAngle: 135.0,centerAngle: 90.0)
     }
    func leftItem(){
        
        self.drawItem(startAngle: 135.0, endAngle: 225.0,centerAngle: 180.0)
     }
    
    
    
    func drawItem(startAngle:CGFloat,endAngle:CGFloat,centerAngle:CGFloat) {
        let centerX = self.centerX
        let centerY = self.centerY
        let width = self.width*0.5
        
        let startAngle:CGFloat = startAngle*Double.pi/180.0
        let endAngle:CGFloat = endAngle*Double.pi/180.0
//        let centerAngle:CGFloat = (startAngle+endAngle)*Double.pi/180.0
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
        layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
        let startPoint = self.getPoint(center: CGPointMake(centerX, centerY), angle: startAngle, radius: width)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width*0.4, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        path.close()
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    
        
        let arrow = self.getArrow()
        arrow.center = self.getPoint(center: CGPointMake(centerX, centerY), angle: centerAngle*Double.pi/180.0, radius: width*0.7)
        arrow.transform = CGAffineTransformMakeRotation(centerAngle*Double.pi/180.0)
        self.addSubview(arrow)
        
//        let arrowLayer = CAShapeLayer()
//        arrowLayer.lineWidth = 1
//        arrowLayer.strokeColor = UIColor.orange.cgColor
//        arrowLayer.fillColor = UIColor.orange.cgColor
//        let centerPoint = self.getPoint(center: CGPointMake(centerX, centerY), angle: centerAngle*Double.pi/180.0, radius: width*0.7)
//        let arrow = UIBezierPath()
//        arrow.move(to: CGPoint(x: centerPoint.x - 5.0, y: centerPoint.y + 5.0))
//        arrow.addLine(to: centerPoint)
//        arrow.addLine(to: CGPoint(x: centerPoint.x - 5.0, y: centerPoint.y - 5.0))
//        arrow.close()
//        arrowLayer.path = arrow.cgPath
//        self.layer.addSublayer(arrowLayer)
        
        
        self.itemLayers.add(layer)
        
    }
//    func leftItem(){
//        let centerX = self.centerX
//        let centerY = self.centerY
//        let width = self.width*0.5
//        
//        let startAngle:CGFloat = 135.0*Double.pi/180.0
//        let endAngle:CGFloat = 225.0*Double.pi/180.0
//        
//        let layer = CAShapeLayer()
//        layer.lineWidth = 1
//        layer.strokeColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C").cgColor
//        layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
////        layer.fillColor = UIColor.white.cgColor
//        let path = UIBezierPath()
//        path.move(to: CGPointMake(centerX, centerY))
//        path.addArc(withCenter: CGPointMake(centerX, centerY), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        path.close()
//        layer.path = path.cgPath
//        self.layer.addSublayer(layer)
//        
//        self.itemLayers.add(layer)
//        
//     }

    
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
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        for item in self.itemLayers{
            let layer:CAShapeLayer = item as! CAShapeLayer
            if(layer.path != nil && layer.path!.contains(point)){
                layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#0383FF").cgColor
            }else{
                layer.fillColor = ColorUtils.hexStringToUIColor(hex: "#303032").cgColor
            }
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
    
    func getArrow() -> UILabel{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.text = "➩"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize:20)
//        label.backgroundColor = UIColor.green
        label.textAlignment  = NSTextAlignment.center
        return label
    }
    
}
