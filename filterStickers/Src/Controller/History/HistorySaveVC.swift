//
//  HistorySaveVC.swift
//  filterStickers
//
//  Created by JOJO on 2021/10/15.
//

import UIKit
import SnapKit
import ZKProgressHUD

class HistorySaveVC: UIViewController {
    var orignalImg: UIImage
    
    init(img: UIImage) {
        self.orignalImg = img
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupView()
        
    }
    

    func setupView() {
        view.backgroundColor = UIColor(hexString: "#EEEEEE")
        //
        let topBanner = UIView()
        topBanner.backgroundColor = UIColor(hexString: "#FFFFFF")
        self.view.addSubview(topBanner)
        topBanner.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
        //
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "edit_return"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        topBanner.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.left.equalTo(5)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        //
        let topTitleLabel = UILabel()
        topTitleLabel.font = GetMyFont(18, "Comic Sans MS Bold")
        topTitleLabel.textColor = UIColor(hexString: "#1B1B1B")
        topTitleLabel.text = "History"
        topBanner.addSubview(topTitleLabel)
        topTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn.snp.centerY)
            $0.centerX.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        let contentImgV = UIImageView()
        contentImgV.image = orignalImg
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentImgV.backgroundColor = UIColor.white
        view.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topBanner.snp.bottom).offset(50)
            $0.height.equalTo(UIScreen.main.bounds.width)
        }
        //
        let bottomBgView = UIView()
        bottomBgView.backgroundColor = UIColor.clear
        view.addSubview(bottomBgView)
        bottomBgView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(contentImgV.snp.bottom)
        }
        //
        let saveBtn = UIButton(type: .custom)
        saveBtn.setImage(UIImage(named: "history_save"), for: .normal)
        saveBtn.addTarget(self, action: #selector(saveBtnClick(sender: )), for: .touchUpInside)
        bottomBgView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(48)
        }
        
    }

}

extension HistorySaveVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func saveBtnClick(sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(orignalImg,nil,nil,nil)
        ZKProgressHUD.showSuccess("Save Successful!")
    }
    
}


