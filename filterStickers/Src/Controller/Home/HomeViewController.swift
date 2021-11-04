//
//  HomeViewController.swift
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    lazy var bgImage:UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "home_bg"));
        imageView.frame = CGRect.init(x: 0, y: 0, width: 375*ScaleWidth, height: 459*ScaleWidth);
        return imageView
    }()
    
    lazy var historyButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 20, y: self.bgImage.bottom+50*ScaleWidth, width: 70*ScaleWidth, height: 70*ScaleWidth)
        button.setBackgroundImage(UIImage(named: "home_btn_history"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(openAlbum(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var createProfile:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: self.view.right-20-(255*ScaleWidth), y: self.historyButton.top, width: 255*ScaleWidth, height: 70*ScaleWidth)
        button.setBackgroundImage(UIImage(named: "hone_btn_startnew"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(openAlbum(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var settingButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 20, y: xNavStatusHeight-44, width: 20*ScaleWidth, height: 20*ScaleWidth)
        button.setBackgroundImage(UIImage(named: "setting"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(storeAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var storeButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: self.view.right-20-(20*ScaleWidth), y: self.settingButton.top, width: 20*ScaleWidth, height: 20*ScaleWidth)
        button.setBackgroundImage(UIImage(named: "store"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(storeAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var imagePickerVC:UIImagePickerController = {
        let pickVc = UIImagePickerController.init()
        pickVc.delegate = self
        pickVc.sourceType = UIImagePickerController.SourceType.photoLibrary
        return pickVc
    }()
    
    var editImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AFlyerLibManage.event_LaunchApp()
        self.view.addSubview(self.bgImage);
        self.view.addSubview(self.historyButton);
        self.view.addSubview(self.createProfile);
        self.view.addSubview(self.settingButton);
        self.view.addSubview(self.storeButton);
        
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    @objc func openAlbum(button:UIButton) {
        if button.tag == 0 {
            let historyVC = HistoryViewController.init()
            self.navigationController?.pushViewController(historyVC, animated: true)
        }else{
            self.present(self.imagePickerVC, animated: true, completion: nil)
        }
    }
    
    @objc func storeAction(button:UIButton){
        if button.tag == 0 {
            let settingVC = SettingViewController.init()
            self.present(settingVC, animated: true, completion: nil)
        }else{
            let storeVC = StoreViewController.init()
            self.present(storeVC, animated: true, completion: nil)
        }
    }
    
    //MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.editImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imagePickerVC.dismiss(animated: true, completion: nil)
        let editVC = EditImageViewController.init()
        editVC.editImage = self.editImage
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    
    
}
