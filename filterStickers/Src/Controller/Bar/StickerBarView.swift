//
//  StickerView.swift
//  filterStickers
//
//  Created by mac on 2021/10/9.
//

import Foundation
import UIKit
class StickerBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, StickerViewDelegate {
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBasic()
    }
    
    public var stickerDidChangeBlock:((_ view: StickerView , _ arr: NSMutableArray) -> ())!
    var stickerDataArr = NSMutableArray.init()
    
    fileprivate func setupBasic(){
        for index in 0 ..< stickerTitleArr.count {
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: Screen_width/4*CGFloat(index), y: 0, width: Screen_width/4 , height: 30)
            button.tag = index
            button.backgroundColor = .white
            if index == 0 {
                button.setTitle("• \(stickerTitleArr[index])", for: .normal)
                button.setTitleColor(FSCommonTextColorTitle, for: .normal)
            }else{
                button.setTitle("  \(stickerTitleArr[index])", for: .normal)
                button.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
            }
            button.titleLabel?.font = GetMyFont(14, "Comic Sans MS Bold")
            button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
            self.addSubview(button)
            buttonArr.add(button)
        }
        self.addSubview(stickerColltionView)
        getStickerData(tag:0)
    }
    
    var buttonArr = NSMutableArray.init()
    var stickerTitleArr = ["apparel","headwear","jewelry","mask"]
    var stickerArr = NSMutableArray.init()
    
    @objc func tapAction(button:UIButton) {
        for index in 0 ..< buttonArr.count{
            let item: UIButton = buttonArr[index] as! UIButton
            if button.tag == item.tag {
                item.setTitle("• \(stickerTitleArr[index])", for: .normal)
                item.setTitleColor(FSCommonTextColorTitle, for: .normal)
            }else{
                item.setTitle("  \(stickerTitleArr[index])", for: .normal)
                item.setTitleColor(MyColorFunc(155, 155, 155, 1.0)!, for: .normal)
            }
        }
        getStickerData(tag:button.tag)
        stickerColltionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
    }
    
    var selectItem: Int = 0
    var selectSticker: UIImage?
    
    
    lazy var stickerColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let colltionView = UICollectionView.init(frame: CGRectMake(20, 30, Screen_width-40, 90), collectionViewLayout: layout)
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView.delegate = self;
        colltionView.dataSource = self;
        colltionView.backgroundColor = .white
        colltionView.showsVerticalScrollIndicator = false
        colltionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: 60, height: 68)
        return colltionView
    
    }()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 4;
        cell.clipsToBounds = true;
        cell.layer.borderColor = UIColor.black.cgColor;
        cell.backgroundColor = MyColorFunc(238, 238, 238, 1.0)
        
        cell.contentView.removeAllSubviews()
//        if indexPath.row == 0{
//            cell.backgroundColor = .clear
//            cell.layer.contents = UIImage.init(named:"edit_no_sticker_pic")?.cgImage
//        }else{
            let stickerImage:UIImage = stickerDataArr[indexPath.row] as! UIImage
            cell.layer.contents = stickerImage.cgImage
            if let selectImg = selectSticker, selectImg == stickerImage {
                cell.layer.borderWidth = 2
            } else {
                cell.layer.borderWidth = 0
            }
//        }
        
        if indexPath.item <= 1 {
            
        } else {
            let pro = UIImageView.init(frame: CGRect.init(x: 60-18, y: 0, width: 18, height: 9))
            pro.image = UIImage.init(named: "item_pro")
            cell.contentView.addSubview(pro)
        }
        
        
        
//        if indexPath.row < 2 {
//            cell.removeAllSubviews()
//        }
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem = indexPath.row
        let stickerImage:UIImage = stickerDataArr[indexPath.row] as! UIImage
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 68))
        imageView.image = stickerImage
        let view = StickerView.init(contentView: imageView)
        view.center = CGPoint.init(x: 150, y: 150)
        view.delegate = self
        view.tag = indexPath.row
        view.setImage(UIImage.init(named: "delete")!, forHandler: StickerViewHandler.close)
        view.setImage(UIImage.init(named: "size_adjust")!, forHandler: StickerViewHandler.rotate)
//        view.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
        view.showEditingHandlers = true
        
        if let currentSelecteSticker = selectedStickerView {
            currentSelecteSticker.showEditingHandlers = false
        }
        
        selectedStickerView = view
        stickerArr.add(view)
        
        if stickerDidChangeBlock != nil {
            stickerDidChangeBlock(view,stickerArr)
        }
//        if indexPath.item == 0 {
//            selectSticker = nil
//        } else {
            selectSticker = stickerImage
//        }
        
        
        stickerColltionView.reloadData()
    }
    
    func getStickerData(tag: Int){
        stickerDataArr.removeAllObjects()
        switch tag {
        case 0:
            for index in 0 ..< 21 {
                stickerDataArr.add(UIImage.init(named: "apparel_\(index+1)")!)
            }
            break
        case 1:
            for index in 0 ..< 21 {
                stickerDataArr.add(UIImage.init(named: "headwear_\(index+1)")!)
            }
            break
        case 2:
            for index in 0 ..< 17 {
                stickerDataArr.add(UIImage.init(named: "jewelry_\(index+1)")!)
            }
            break
        case 3:
            for index in 0 ..< 21 {
                stickerDataArr.add(UIImage.init(named: "mask_\(index+1)")!)
            }
            break
        default:
            break
        }
        stickerColltionView.reloadData()
    }
    
    private var _selectedStickerView:StickerView?
    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }
    
    func tap(_ sender:UITapGestureRecognizer) {
        self.selectedStickerView?.showEditingHandlers = false
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        let str1 = sg_getAnyObjectMemoryAddress(object: stickerView)
        
        var  item:StickerView
        for i in 0 ..< stickerArr.count {
            item = stickerArr[i] as! StickerView
            let str2 = sg_getAnyObjectMemoryAddress(object: item)
            if str1 == str2 {
                stickerArr.removeObject(at: i)
                break
            }
        }
        
        let view = StickerView.init(contentView: UIImageView.init())
        view.tag = 99999
        if stickerDidChangeBlock != nil {
            stickerDidChangeBlock(view,stickerArr)
        }
    }
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func sg_getAnyObjectMemoryAddress(object: AnyObject) -> String {
        let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
        return String(describing: str)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
