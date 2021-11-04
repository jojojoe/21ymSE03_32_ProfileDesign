//
//  boderView.swift
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

import Foundation
class BoderBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasic()
    }
    
    public var boderDidChangeBlock:((_ tag:Int,_ value:CGFloat,_ color:UIColor) -> ())!
    var colorDataArr = NSMutableArray.init()
    lazy var boderButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 10, width: Screen_width/3 , height: 30)
        button.tag = 0
        button.backgroundColor = .white
        button.setTitle("• border", for: .normal)
        button.setTitleColor(FSCommonTextColorTitle, for: .normal)
        button.titleLabel?.font = GetMyFont(14, "Comic Sans MS Bold")
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var backgroundButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/3*1, y: 10, width: Screen_width/3 , height: 30)
        button.tag = 1
        button.backgroundColor = .white
        button.setTitle("  background", for: .normal)
        button.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
        button.titleLabel?.font = GetMyFont(14, "Comic Sans MS Bold")
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var colorButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/3*2, y: 10, width: Screen_width/3 , height: 30)
        button.tag = 2
        button.backgroundColor = .white
        button.setTitle("  color", for: .normal)
        button.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
        button.titleLabel?.font = GetMyFont(14, "Comic Sans MS Bold")
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var boderSlider :UISlider = {
        let slider = UISlider.init(frame: CGRect.init(x: 30, y: self.boderButton.bottom+35, width: Screen_width-60, height: 15))
        slider.tag = 0
        slider.minimumValue = 0
        slider.maximumValue = 60
        slider.value = 30
        slider.isContinuous = true
        slider.transform =  CGAffineTransform.init(scaleX: 1.0, y:1)
            
        slider.minimumTrackTintColor = FSCommonTextColorTitle
        slider.maximumTrackTintColor = FSCommonTextColorTitle
        slider.thumbTintColor = FSCommonTextColorTitle
        
        /// 事件监听
        slider.addTarget(self, action: #selector(sliderDidChange(sender:)), for: .valueChanged)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .normal)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .highlighted)
        
        return slider
        
    }()
    
    lazy var backgroundSlider :UISlider = {
        let slider = UISlider.init(frame: CGRect.init(x: 30, y: self.boderButton.bottom+35, width: Screen_width-60, height: 15))
        slider.tag = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.isHidden = true
        slider.isContinuous = true
        slider.transform =  CGAffineTransform.init(scaleX: 1.0, y:1)
        
        slider.minimumTrackTintColor = FSCommonTextColorTitle
        slider.maximumTrackTintColor = FSCommonTextColorTitle
        slider.thumbTintColor = FSCommonTextColorTitle
        
        /// 事件监听
        slider.addTarget(self, action: #selector(sliderDidChange(sender:)), for: .valueChanged)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .normal)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .highlighted)
        
        return slider
        
    }()
    
    @objc func sliderDidChange(sender: UISlider) {
        if boderDidChangeBlock != nil {
            boderDidChangeBlock(sender.tag,CGFloat(sender.value),.clear)
        }
    }
    
    fileprivate func setupBasic(){
        self.addSubview(boderButton)
        self.addSubview(backgroundButton)
        self.addSubview(colorButton)
        
        self.addSubview(boderSlider)
        self.addSubview(backgroundSlider)
        self.addSubview(colorColltionView)
        
        colorDataArr = getColorData()
    }
    
    @objc func tapAction(button:UIButton) {
        if button.tag == 0 {
            boderSlider.isHidden = false
            backgroundSlider.isHidden = true
            colorColltionView.isHidden = true
            boderButton.setTitle("• border", for: .normal)
            boderButton.setTitleColor(FSCommonTextColorTitle, for: .normal)
            backgroundButton.setTitle("  background", for: .normal)
            backgroundButton.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
            colorButton.setTitle("  color", for: .normal)
            colorButton.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
        }else if button.tag == 1{
            boderSlider.isHidden = true
            backgroundSlider.isHidden = false
            colorColltionView.isHidden = true
            boderButton.setTitle("  border", for: .normal)
            boderButton.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
            backgroundButton.setTitle("• background", for: .normal)
            backgroundButton.setTitleColor(FSCommonTextColorTitle, for: .normal)
            colorButton.setTitle("  color", for: .normal)
            colorButton.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
        }else if button.tag == 2{
            boderSlider.isHidden = true
            backgroundSlider.isHidden = true
            colorColltionView.isHidden = false
            boderButton.setTitle("  border", for: .normal)
            boderButton.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
            backgroundButton.setTitle("  background", for: .normal)
            backgroundButton.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
            colorButton.setTitle("• color", for: .normal)
            colorButton.setTitleColor(FSCommonTextColorTitle, for: .normal)
        }
        
        
    }
    
    var selectItem: Int = 0
    
    lazy var colorColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let colltionView = UICollectionView.init(frame: CGRectMake(20, self.boderButton.bottom+15, Screen_width-40, 70), collectionViewLayout: layout)
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView.delegate = self;
        colltionView.dataSource = self;
        colltionView.backgroundColor = .white
        colltionView.isHidden = true
        colltionView.showsVerticalScrollIndicator = false
        colltionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: 40, height: 68)
        return colltionView
    
    }()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 4;
        cell.clipsToBounds = true;
        cell.layer.borderColor = UIColor.black.cgColor;
        
        if selectItem == indexPath.row && selectItem != 0 {
            cell.layer.borderWidth = 2
        }else{
            cell.layer.borderWidth = 0
        }
        
        if indexPath.row == 0{
            cell.backgroundColor = .clear
            cell.layer.contents = UIImage.init(named:"edit_blank")?.cgImage
        }else{
            cell.layer.contents = nil
            cell.backgroundColor = colorDataArr[indexPath.row] as? UIColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem = indexPath.row
        if boderDidChangeBlock != nil {
            boderDidChangeBlock(2,0,colorDataArr[indexPath.row] as! UIColor)
        }
        
        self.colorColltionView.reloadData()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
}
