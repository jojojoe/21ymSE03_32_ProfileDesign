//
//  FilterBarView.swift
//  filterStickers
//
//  Created by mac on 2021/10/12.
//

import Foundation
class FilterBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource{

    var editView = EditPhotoView()
    var filterDataArr = NSMutableArray.init()
    
    private var _image = UIImage.init()
    var image:UIImage {
        set {
            _image = newValue
            filterDataArr = DataTool.pictureProcessData(image)
            filterColltionView.reloadData()
        }
        get {
            return _image
        }
    }
    
    
    var originalImg: UIImage = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(filterColltionView)
    }
    
    public var fliterDidChangeBlock:((_ pro: Int) -> ())!
    var stickerDataArr = NSMutableArray()
    var filterImage = UIImage()
    var selectItem: Int = 0
    
    lazy var filterColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let colltionView = UICollectionView.init(frame: CGRectMake(20, 10, Screen_width-40, 80), collectionViewLayout: layout)
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView.delegate = self;
        colltionView.dataSource = self;
        colltionView.backgroundColor = .white
        colltionView.showsVerticalScrollIndicator = false
        colltionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: 60, height: 60)
        return colltionView
    
    }()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 4;
        cell.clipsToBounds = true;
        cell.layer.borderColor = UIColor.black.cgColor;
        
        
        cell.contentView.removeAllSubviews()
        
        if selectItem == indexPath.row && selectItem != 0 {
            cell.layer.borderWidth = 2
        }else{
            cell.layer.borderWidth = 0
        }
        
        let contentdic = filterDataArr[indexPath.row] as! NSDictionary
        let image:UIImage = contentdic["image"] as! UIImage
        
        
        let filterImgV = UIImageView()
        filterImgV.contentMode = .scaleAspectFill
        filterImgV.clipsToBounds = true
        cell.contentView.addSubview(filterImgV)
        filterImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
            
        }
        if indexPath.row == 0{
            cell.backgroundColor = .clear
//            cell.layer.contents = UIImage.init(named:"edit_no_sticker_pic")?.cgImage
            filterImgV.contentMode = .scaleAspectFit
            filterImgV.image = UIImage.init(named:"edit_no_sticker_pic")
        }else{
            filterImgV.contentMode = .scaleAspectFill
            filterImgV.image = image
        }
        
        if indexPath.row <= 1 {
            
        } else {
            let pro = UIImageView.init(frame: CGRect.init(x: 60-18, y: 0, width: 18, height: 9))
            pro.image = UIImage.init(named: "item_pro")
            cell.contentView.addSubview(pro)
        }
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem = indexPath.row
        
        let contentdic = filterDataArr[indexPath.row] as! NSDictionary
        let name = contentdic["name"] as! NSString
        
        if let image = DataTool.pictureProcessData(originalImg, matrixName: name as String) {
            editView.image = image
        }
        
        if fliterDidChangeBlock != nil {
            if indexPath.row >= 2 {
                fliterDidChangeBlock(1)
            }else{
                fliterDidChangeBlock(0)
            }
            
        }
        filterColltionView.reloadData()
    }
    
    func resetData() {
        let contentdic = filterDataArr[0] as! NSDictionary
        let name = contentdic["name"] as! NSString
        if let image = DataTool.pictureProcessData(originalImg, matrixName: name as String) {
            editView.image = image
        }
        selectItem = 0
        filterColltionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
