//
//  DrawBorderView.swift
//  filterStickers
//
//  Created by mac on 2021/10/11.
//

import Foundation

class DrawBorderView: UIView {
    
    var kBorderWith:CGFloat = 30
    
//    var ctx = UIGraphicsGetCurrentContext()
    
    var kBorderColor : UIColor = MyColorFunc(234, 117, 141, 1.0)!
    var kBorderRect = CGRect()
    
    var dotteline = CAShapeLayer.init()
    override func draw(_ rect: CGRect) {
        
    }
    
    func drawCircleTipWithRects(_ rect: CGRect) {
        dotteline.lineWidth = 30
        dotteline.strokeColor = MyColorFunc(234, 117, 141, 1.0)!.cgColor
        dotteline.fillColor = UIColor.clear.cgColor
        let dottePath = CGMutablePath()
        dottePath.addEllipse(in: rect)
        dotteline.path = dottePath
        self.layer.addSublayer(dotteline)
        
    }
    
    func strokeColor(color:UIColor) {
        dotteline.strokeColor = color.cgColor
    }
    
    func lineWidth(width:CGFloat) {
        dotteline.lineWidth = width
    }
}

