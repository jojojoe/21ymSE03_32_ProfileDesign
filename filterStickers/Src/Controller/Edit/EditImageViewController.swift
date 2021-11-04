//
//  EditImageViewController.swift
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

import Foundation
import UIKit
class EditImageViewController: UIViewController{
    
    public var editImage = UIImage()
    var colorString: String?
    var stickerViewArr = NSMutableArray()
    var tattooViewArr = NSMutableArray()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backItem = UIBarButtonItem.init(image: UIImage.init(named: "edit_return"), style: .plain, target: self, action: #selector(backAction))
        backItem.tintColor = FSBUttonColor
        self.navigationItem.leftBarButtonItem = backItem
        
        let saveItem = UIBarButtonItem.init(image: UIImage.init(named: "edit_save"), style: .plain, target: self, action: #selector(saveAction))
        saveItem.tintColor = FSBUttonColor
        self.navigationItem.rightBarButtonItem = saveItem
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = FSCommonVCBGColor
        
    }
    
    lazy var editView:EditPhotoView = {
        let view = EditPhotoView.init()
        view.clipsToBounds = true
        view.frame = CGRect.init(x: 0, y: xNavStatusHeight + 50, width: Screen_width, height: Screen_width)
        view.backgroundColor = .white
        return view
    }()
        
//    lazy var userEnabledView:UIView = {
//        let view = UIView.init()
//        view.frame = editView.bounds
//        view.backgroundColor = .clear
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(editView)
//        editView.addSubview(userEnabledView)
        
        
        self.view.addSubview(safeView)//boder
        
        self.view.addSubview(boderButton)//boder
        self.view.addSubview(filterButton)//滤镜
        self.view.addSubview(stickerButton)//贴纸
        self.view.addSubview(tattooButton)//纹身
        self.view.addSubview(textButton)//文本
        
        self.view.addSubview(bottomBarView)//选择器
        
        editView.image = editImage
        
        let aTapGR = UITapGestureRecognizer.init(target: self, action: #selector(editingHandlers))
        editView.addGestureRecognizer(aTapGR)
    }
    
    @objc func editingHandlers() {
        stickerBarView.selectedStickerView?.showEditingHandlers = false
        tattooBarView.selectedStickerView?.showEditingHandlers = false
        richTextBarView.selectedStickerView?.showEditingHandlers = false
    }
    
    
    
    //是否涉及购买
    var whetherPro = 0
    
    @objc func tapAction(button:UIButton) {
        if button.tag != 4 {
            bottomBarView.frame.origin.y = Screen_height-Screen_safeArea-50
            bottomBarView.tag = button.tag
            bottomBarView.buttonDidChangeBlock = { [self] (tag  :Int) -> () in
                bottomBarView.frame.origin.y = Screen_height
                boderBarView.frame.origin.y = Screen_height
                stickerBarView.frame.origin.y = Screen_height
                tattooBarView.frame.origin.y = Screen_height
                filterBarView.frame.origin.y = Screen_height
                
//                userEnabledView.isHidden = false
//                editView.bringSubviewToFront(userEnabledView)
                editingHandlers()
                
                if tag == 0 {
    //                let pathStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString
    //                let path = pathStr.strings(byAppendingPaths: ["user.plist"]).last!
    //                photoModel = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! PhotoDataModel
    //                let str:String = UIColor.red.hexString!
    //                photoModel.balance = colorString!
                }else if tag == 1{
                    switch bottomBarView.tag {
                    case 0:
                        editView.drawBorderView.dotteline.lineWidth = 30
                        editView.hollowedView.alpha = 1
                        editView.drawBorderView.dotteline.strokeColor = MyColorFunc(234, 117, 141, 1.0)!.cgColor
                        break
                    case 1:
                        filterBarView.resetData()
                        break
                    case 2:
                        
                        break
                    case 3:
                        
                        break
                    case 4:
                        break
                    default:
                        break
                    }
                }
            }
        }
        
        editingHandlers()
        if button.tag == 0 {
            print("选边框")
            self.view.addSubview(boderBarView)
            bottomBarView.setViewTitle(title: "boder")
            bottomBarView.wrongButton.isHidden = false
            boderBarView.frame.origin.y = Screen_height-bottomBarView.height-boderBarView.height
            boderBarView.boderDidChangeBlock = { [self] (tag  :Int , value : CGFloat , color: UIColor) -> () in
                if tag == 0 {
                    editView.drawBorderView.dotteline.lineWidth = value
                }else if tag == 1{
                    editView.hollowedView.alpha = value
                }else if tag == 2{
                    editView.drawBorderView.dotteline.strokeColor = color.cgColor
//                    colorString = color.hexString!
                }
            }
        }else if button.tag == 1{
            print("滤镜")
            self.view.addSubview(filterBarView)
            bottomBarView.wrongButton.isHidden = false
            bottomBarView.setViewTitle(title: "filter")
            filterBarView.frame.origin.y = Screen_height-bottomBarView.height-filterBarView.height
            let img = editImage.reSizeImage(reSize: CGSize(width: 300, height: 300 * editImage.size.height / editImage.size.width))
//            let img = editImage
            filterBarView.image = img
            filterBarView.originalImg = editImage
            filterBarView.editView = editView
            filterBarView.fliterDidChangeBlock = { [self] ( pro: Int) -> () in
                whetherPro = pro
            }
        }else if button.tag == 2{
            print("贴纸")
            self.view.addSubview(stickerBarView)
            bottomBarView.setViewTitle(title: "sticker")
            bottomBarView.wrongButton.isHidden = true
//            userEnabledView.isHidden = true
            stickerBarView.frame.origin.y = Screen_height-bottomBarView.height-stickerBarView.height
            stickerBarView.stickerDidChangeBlock = { [self] ( view: StickerView , arr:NSMutableArray) -> () in
                if view.tag != 99999 {
                    view.center = CGPoint(x: editView.bounds.width / 2, y: editView.bounds.height / 2)
                    editView.addSubview(view)
                }
                var item:StickerView
                for i in 0 ..< arr.count {
                    item = arr[i] as! StickerView
                    if item.tag >= 2 {
                        whetherPro = 1
                        break
                    }else{
                        whetherPro = 0
                    }
                }
                
                stickerViewArr = arr
            }
        }else if button.tag == 3{
            print("纹身")
            self.view.addSubview(tattooBarView)
            bottomBarView.setViewTitle(title: "tattoo")
            bottomBarView.wrongButton.isHidden = true
//            userEnabledView.isHidden = true
            tattooBarView.frame.origin.y = Screen_height-bottomBarView.height-tattooBarView.height
            tattooBarView.tattooDidChangeBlock = { [self] ( view: StickerView , arr:NSMutableArray) -> () in
                if view.tag != 99999 {
                    view.center = CGPoint(x: editView.bounds.width / 2, y: editView.bounds.height / 2)
                    editView.addSubview(view)
                }
                
                var item:StickerView
                for i in 0 ..< arr.count {
                    item = arr[i] as! StickerView
                    if item.tag >= 2 {
                        whetherPro = 1
                        break
                    }else{
                        whetherPro = 0
                    }
                }
                
                tattooViewArr = arr
                
            }
        }else if button.tag == 4{
            print("字体")
            UIApplication.shared.keyWindow?.addSubview(richTextBarView)
            bottomBarView.setViewTitle(title: "text")
//            userEnabledView.isHidden = true
            richTextBarView.frame.origin.y = 0
            richTextBarView.textView.text = "text here"
            richTextBarView.changeAttributedText()
            richTextBarView.richTextDidChangeBlock = { [self] (_ view: StickerView) -> () in
                if view.tag == 0 {
                    view.center = CGPoint(x: editView.bounds.size.width / 2, y: editView.bounds.size.height / 2)
                    view.bounds = CGRect(x: 0, y: 0, width: editView.bounds.size.width - 160, height: editView.bounds.size.height - 220)
                    editView.addSubview(view)
                }
                richTextBarView.frame.origin.y = Screen_height
//                userEnabledView.isHidden = false
//                editView.bringSubviewToFront(userEnabledView)
//                editingHandlers()
            }
            
        }
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func Screenshot(view: UIView) -> UIImage {//截取指定UIView
        UIGraphicsBeginImageContextWithOptions(view.frame.size,false,UIScreen.main.scale)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    
    @objc func saveAction(){
        editingHandlers()
        
        //
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urlForDocument[0] as NSURL
        let filePath = createFolder(name: "downloadImage", baseUrl: url)
        print("文件夹: \(filePath)")
        
        let image = Screenshot(view: editView)
        if whetherPro == 1 {
            self.view.addSubview(springFrameViewBgView)
            self.view.addSubview(springFrameView)
            springFrameViewBgView.isHidden = false
            springFrameView.frame.origin.y = 250
            springFrameView.springFrameDidChangeBlock = { [self] (_ tag: Int) -> () in
                if tag == 0{
                    springFrameView.frame.origin.y = Screen_height
                    springFrameViewBgView.isHidden = true
                }else{
                    let yue = priceSave()
                    if yue < 100 {
//                        springFrameView.tips = "Your balance is insufficient, please return to home -> store recharge."
                        let storeVC = StoreViewController.init()
                        self.present(storeVC, animated: true, completion: nil)
                    }else{
                        let save:Bool = StoreViewController.keyChainSaveData(data: yue-100, withIdentifier: balanceKey)
                        print("\(save ? "存储成功":"存储失败")")
                        let imagePath = NSHomeDirectory() + "/Documents/downloadImage/\(Date()).png"
                        let data:Data = image.pngData()!
                        try? data.write(to: URL(fileURLWithPath: imagePath))
                        UIImageWriteToSavedPhotosAlbum(image,view,nil,nil)

                        springFrameView.frame.origin.y = Screen_height
                        springFrameViewBgView.isHidden = true
                        ZKProgressHUD.showSuccess("Save Successful!")
                    }
                }
            }
            print("1111111")
        }else{
            print("0000")
            let imagePath = NSHomeDirectory() + "/Documents/downloadImage/\(Date()).png"
            let data:Data = image.pngData()!
            try? data.write(to: URL(fileURLWithPath: imagePath))
            UIImageWriteToSavedPhotosAlbum(image,view,nil,nil)
            ZKProgressHUD.showSuccess("Save Successful!")
        }
    }
    
    //MARK: lazyView
    lazy var springFrameViewBgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Screen_width, height: Screen_height))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
       return view
    }()
    lazy var springFrameView: SpringFrameView = {
        let view = SpringFrameView.init(frame: CGRect.init(x: (Screen_width-250)/2, y: 0, width: 250, height: 240))
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        return view
    }()
    
    lazy var bottomBarView: BottomBarView = {
        let view = BottomBarView.init(frame: CGRect.init(x: 0, y: Screen_height, width: Screen_width, height: Screen_safeArea+50))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var boderBarView: BoderBarView = {
        let view = BoderBarView.init(frame: CGRect.init(x: 0, y: Screen_height, width: Screen_width, height: 130))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var filterBarView: FilterBarView = {
        let view = FilterBarView.init(frame: CGRect.init(x: 0, y: Screen_height, width: Screen_width, height: 80))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var stickerBarView: StickerBarView = {
        let view = StickerBarView.init(frame: CGRect.init(x: 0, y: Screen_height, width: Screen_width, height: 130))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tattooBarView: TattooBarView = {
        let view = TattooBarView.init(frame: CGRect.init(x: 0, y: Screen_height, width: Screen_width, height: 100))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var richTextBarView: RichTextBarView = {
        let view = RichTextBarView.init(frame: CGRect.init(x: 0, y: Screen_height, width: Screen_width, height: Screen_height))
        view.tag = 99999
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 0.75)
        return view
    }()
    
    lazy var boderButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: Screen_height-Screen_safeArea-70, width: Screen_width/5 , height: 70)
        button.tag = 0
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_boder"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var filterButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/5*1, y: self.boderButton.top, width: self.boderButton.width , height: self.boderButton.height)
        button.tag = 1
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_filter"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var stickerButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/5*2, y: self.boderButton.top, width: self.boderButton.width , height: self.boderButton.height)
        button.tag = 2
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_sticker"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tattooButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/5*3, y: self.boderButton.top, width: self.boderButton.width , height: self.boderButton.height)
        button.tag = 3
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_tattoo"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/5*4, y: self.boderButton.top, width: self.boderButton.width , height: self.boderButton.height)
        button.tag = 4
        button.backgroundColor = .white
        button.setImage(UIImage(named: "edit_text"), for: .normal)
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var safeView: UIView = {
        let view = UIView.init()
        view.frame = CGRect.init(x: 0, y: Screen_height-Screen_safeArea, width: Screen_width , height: Screen_safeArea)
        view.backgroundColor = .white
        return view
    }()
    
}
