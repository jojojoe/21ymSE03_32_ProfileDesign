//
//  SpringFrameView.swift
//  filterStickers
//
//  Created by mac on 2021/10/13.
//

import Foundation
class SpringFrameView: UIView {
    
    public var springFrameDidChangeBlock:(( _ tag: Int) -> ())!
    private var _tips:String = "Using paid items will cost 100 coins."
    var tips:String {
        set {
            _tips = newValue
            springLabel.text = _tips
        }
        get {
            return _tips
        }
    }
    
    lazy var deleteButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.tag = 0
        button.frame = CGRect.init(x: self.width-30, y: 10, width: 20 , height: 20)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "edit_next_close"), for: .normal)
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return button
    }()
    
    lazy var diamondsImage:UIImageView = {
        let image = UIImageView.init()
        image.frame = CGRect.init(x: (self.width-60)/2, y: 50, width: 60 , height: 40)
        image.backgroundColor = .clear
        image.image = UIImage.init(named: "popup_coins_cost")
        return image
    }()
    
    lazy var springLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 30, y: diamondsImage.bottom+10, width: self.width-60 , height: 60)
        label.textAlignment = .center
        label.text = tips
        label.font = GetMyFont(14, "Comic Sans MS Bold")
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var confirmButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: (self.width-188)/2, y: springLabel.bottom+10, width: 188 , height: 48)
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(named: "popup_coins_btn_bg"), for: .normal)
        button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = GetMyFont(20, "NunitoSans")
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasic()
    }
    
    fileprivate func setupBasic(){
        self.addSubview(deleteButton)
        self.addSubview(diamondsImage)
        self.addSubview(springLabel)
        self.addSubview(confirmButton)
        
    }
    
    @objc func deleteAction(){
        
        if springFrameDidChangeBlock != nil {
            springFrameDidChangeBlock(0)
        }
    }
    
    @objc func confirmAction(){
        
        if springFrameDidChangeBlock != nil {
            springFrameDidChangeBlock(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

