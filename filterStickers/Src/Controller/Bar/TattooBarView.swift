//
//  TattooView.swift
//  filterStickers
//
//  Created by mac on 2021/10/9.
//

import Foundation
import UIKit
class TattooBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, StickerViewDelegate {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for index in 0 ..< 21 {
            tattooDataArr.add(UIImage.init(named: "tattoo_\(index+1)")!)
        }
        tattooColltionView.reloadData()
        self.addSubview(tattooColltionView)
    }
    
    public var tattooDidChangeBlock:((_ view: StickerView , _ arr: NSMutableArray) -> ())!
    var tattooDataArr = NSMutableArray()
    var tattooArr = NSMutableArray.init()
    var selectItemImg: UIImage?
    
    lazy var tattooColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let colltionView = UICollectionView.init(frame: CGRectMake(20, 5, Screen_width-40, 90), collectionViewLayout: layout)
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
        return tattooDataArr.count
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
            let tattooImage:UIImage = tattooDataArr[indexPath.row] as! UIImage
            cell.layer.contents = tattooImage.cgImage
        if selectItemImg == tattooImage {
            cell.layer.borderWidth = 2
        }else{
            cell.layer.borderWidth = 0
        }
//        }
        
        if indexPath.item <= 1 {
            
        } else {
            let pro = UIImageView.init(frame: CGRect.init(x: 60-18, y: 0, width: 18, height: 9))
            pro.image = UIImage.init(named: "item_pro")
            cell.contentView.addSubview(pro)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectItem = indexPath.row
        
        let tattooImage:UIImage = tattooDataArr[indexPath.row] as! UIImage
        selectItemImg = tattooImage
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 68))
        imageView.image = tattooImage
        let view = StickerView.init(contentView: imageView)
        view.tag = indexPath.row
        view.center = CGPoint.init(x: 150, y: 150)
        view.delegate = self
        view.setImage(UIImage.init(named: "delete")!, forHandler: StickerViewHandler.close)
        view.setImage(UIImage.init(named: "size_adjust")!, forHandler: StickerViewHandler.rotate)
//        view.setImage(UIImage.init(named: "Flip")!, forHandler: StickerViewHandler.flip)
        
        view.showEditingHandlers = true
        if let currentSelecteSticker = selectedStickerView {
            currentSelecteSticker.showEditingHandlers = false
        }
        
        selectedStickerView = view
        tattooArr.add(view)
        if tattooDidChangeBlock != nil {
            tattooDidChangeBlock(view,tattooArr)
        }
        tattooColltionView.reloadData()
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
        
        for i in 0 ..< tattooArr.count {
            item = tattooArr[i] as! StickerView
            let str2 = sg_getAnyObjectMemoryAddress(object: item)
            if str1 == str2 {
                tattooArr.removeObject(at: i)
                break
            }
            
        }
        let view = StickerView.init(contentView: UIImageView.init())
        view.tag = 99999
        if tattooDidChangeBlock != nil {
            tattooDidChangeBlock(view,tattooArr)
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
