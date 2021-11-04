//
//  BottomBarView.swift
//  filterStickers
//
//  Created by mac on 2021/10/9.
//

import Foundation
class BottomBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasic()
    }
    
    public var buttonDidChangeBlock:((_ tag:Int) -> ())!
    
    lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 20, y: 0, width: 50 , height: 50)
        button.tag = 0
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_next_done"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var wrongButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width-70, y: 0, width: 50 , height: 50)
        button.tag = 1
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_next_close"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 70, y: 0, width: Screen_width-70-70 , height: 50)
        label.textAlignment = .center
        
        label.font = GetMyFont(18, "Comic Sans MS Bold")
        label.textColor = FSCommonTextColorTitle
        return label
    }()
    
    fileprivate func setupBasic(){
        self.addSubview(rightButton)
        self.addSubview(wrongButton)
        self.addSubview(titleLabel)
    }
    
    @objc func tapAction(button:UIButton) {
        if buttonDidChangeBlock != nil{
            buttonDidChangeBlock(button.tag)
        }
    }
    func setViewTitle(title:String) {
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
