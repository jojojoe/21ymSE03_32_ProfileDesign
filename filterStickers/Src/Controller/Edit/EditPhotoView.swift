//
//  EditPhotoView.swift
//  filterStickers
//
//  Created by mac on 2021/10/11.
//

import Foundation
class EditPhotoView: UIView {
    
    public var editDidChangeBlock:((_ image:UIImage) -> ())!
    
    private var _image = UIImage.init()
    var image:UIImage {
        set {
            _image = newValue
            imageView.image = _image
        }
        get {
            return _image
        }
    }
    override init(frame: CGRect) {
//        self.image = UIImage.init()
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(hollowedView)
        self.addSubview(drawBorderView)
    }

    lazy var imageView:UIImageView = {
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_width)
        
        
        return view
    }()
    
    
    
    
    lazy var hollowedView:UIImageView = {
        let view = UIImageView.init()
        view.alpha = 1
        view.frame = imageView.bounds
        view.backgroundColor = .white
        view.layer.mask = maskWithinStyle(rect: imageView.bounds)
        return view
    }()
    
    
    
    lazy var drawBorderView:DrawBorderView = {
        let view = DrawBorderView.init()
        view.frame = CGRectMake(imageView.bounds.width/2*0.2,
                                imageView.bounds.width/2*0.2,
                                imageView.bounds.width*0.8,
                                imageView.bounds.height*0.8)
        view.backgroundColor = .clear
        view.drawCircleTipWithRects(CGRectMake(0, 0,
                                               imageView.frame.width*0.8,
                                               imageView.frame.height*0.8))
        return view
    }()

    
    //内圆镂空
    func maskWithinStyle(rect:CGRect) -> CAShapeLayer {
        let path = UIBezierPath.init(rect: rect)
        let x = rect.size.width/2.0
        let y = rect.size.width/2.0
        let radius = min(x, y)*0.8

        let cycle = UIBezierPath.init(arcCenter: CGPoint.init(x: x, y: y), radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)

        path.append(cycle)

        let maskLayer = CAShapeLayer.init()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        return maskLayer
        
    }
    
    //外圆镂空
    func maskOutsideStyle(rect:CGRect) -> CAShapeLayer {
        let x = rect.size.width/2.0
        let y = rect.size.width/2.0
        let radius = min(x, y)*0.8

        let cycle = UIBezierPath.init(arcCenter: CGPoint.init(x: x, y: y), radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2, clockwise: true)

        let maskLayer = CAShapeLayer.init()
        maskLayer.path = cycle.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.nonZero
        
        return maskLayer
        
    }
//    
//    func setImage(image:UIImage) {
//        imageView.image = image
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
