//
//  HistoryViewController.swift
//  filterStickers
//
//  Created by mac on 2021/10/13.
//

import Foundation
import SnapKit

class HistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let backItem = UIBarButtonItem.init(image: UIImage.init(named: "edit_return"), style: .plain, target: self, action: #selector(backAction))
//        backItem.tintColor = FSBUttonColor
//        self.navigationItem.leftBarButtonItem = backItem
//
//        self.navigationController?.navigationBar.barTintColor = .white
//        self.view.backgroundColor = FSCommonVCBGColor
//        self.title = "History"
        self.navigationController?.isNavigationBarHidden = true
    }
    
    var historyDataArr: NSArray = []
    lazy var historyColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let colltionView = UICollectionView.init(frame: CGRectMake(10, xNavStatusHeight+10, Screen_width-20, Screen_height-xNavStatusHeight-10), collectionViewLayout: layout)
        colltionView.backgroundColor = .clear
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView.delegate = self;
        colltionView.dataSource = self;
        layout.itemSize = CGSize.init(width: (colltionView.width-10)/2, height: (colltionView.width-10)/2)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        return colltionView
    
    }()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let pro = UIImageView.init(frame: cell.bounds)
        
        let imagePath = NSHomeDirectory() + "/Documents/downloadImage/\(historyDataArr[indexPath.row])"
        let url = URL.init(fileURLWithPath: imagePath)
        let readHandler = try! FileHandle(forReadingFrom:url)
        let data = readHandler.readDataToEndOfFile()
        pro.image = UIImage.init(data: data)
        cell.addSubview(pro)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imagePath = NSHomeDirectory() + "/Documents/downloadImage/\(historyDataArr[indexPath.row])"
        let url = URL.init(fileURLWithPath: imagePath)
        let readHandler = try! FileHandle(forReadingFrom:url)
        let data = readHandler.readDataToEndOfFile()
        
//        let editVC = EditImageViewController.init()
//        editVC.editImage = UIImage.init(data: data)!
//        self.navigationController?.pushViewController(editVC, animated: true)
        
        if let img_m = UIImage.init(data: data) {
            let historySaveVC = HistorySaveVC(img: img_m)
            
            self.navigationController?.pushViewController(historySaveVC, animated: true)
        }
        
        
        
        
    }
    
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.view.addSubview(historyColltionView)
        
        
        
        let manager = FileManager.default
        let imagePath = NSHomeDirectory() + "/Documents/downloadImage"
        do {
            if let historyDataArr_m = try? manager.contentsOfDirectory(atPath: imagePath) as NSArray {
                historyDataArr = historyDataArr_m
            }
             
        } catch {
            
        }
        
        print("\(historyDataArr)")
        
    }
    func setupView() {
        //
        view.backgroundColor = UIColor(hexString: "#EEEEEE")
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
        
    }
    
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
