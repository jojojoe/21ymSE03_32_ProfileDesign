//
//  StoreViewController.swift
//  filterStickers
//
//  Created by mac on 2021/10/8.
//
import StoreKit
import Alamofire
import Foundation
import StoreKit
import ZKProgressHUD
import SwiftyStoreKit


class StoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SKProductsRequestDelegate, SKPaymentTransactionObserver{
    var currentBuyModel: StoreItemModal?
    var currencyCode = "USD"
    let buyManage = HightLightingPriceManager.default
    
    lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: 0, width: 50 , height: 50)
        button.tag = 0
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "setting_back"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    lazy var diamondsImage:UIImageView = {
        let image = UIImageView.init()
        image.frame = CGRect.init(x: Screen_width-100, y: 15, width: 30 , height: 20)
        image.backgroundColor = .clear
        image.image = UIImage.init(named: "popup_coins_cost")
        return image
    }()
    
    lazy var diamondsLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: diamondsImage.right, y: 0, width: 60 , height: 50)
        label.textAlignment = .center
        label.font = GetMyFont(18, "Comic Sans MS Bold")
        label.textColor = .white
        return label
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 0, y: 0, width: 80 , height: 50)
        label.textAlignment = .center
        label.centerX = self.view.centerX
        label.text = "store"
        label.font = GetMyFont(18, "Comic Sans MS Bold")
        label.textColor = .white
        return label
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        diamondsLabel.text = "\(priceSave())"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        buyManage.addObserver()
        self.view.addSubview(rightButton)
        self.view.addSubview(diamondsImage)
        self.view.addSubview(diamondsLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(storeColltionView)
        
        diamondsLabel.text = "\(priceSave())"
        addObserver()
        
        setupPurchaseManager()
    }
    
    func setupPurchaseManager() {
        buyManage.callBackBlock = { transaction in
            switch transaction.transactionState {
            case .purchased:
                print("💩💩💩💩purchased")
                ZKProgressHUD.dismiss()
                // 购买成功
                SKPaymentQueue.default().finishTransaction(transaction)
                if let model = self.currentBuyModel {
                    var price = model.zhenPrice!.count > 0 ? model.zhenPrice : model.price
                    price!.remove(at: price!.startIndex)
                    self.diamondsLabel.text = "\(buyStore(price:model.consCount!))"
                    AFlyerLibManage.event_PurchaseSuccessAll(symbolType: "$", needMoney: Float(Double(price!) ?? 0.0), iapId: model.iapid ?? "")
 
                }
 
                break
                
            case .purchasing:
                print("💩💩💩💩purchasing")
                break
                
            case .restored:
                print("💩💩💩💩restored")
                ZKProgressHUD.dismiss()
                ZKProgressHUD.showError(transaction.error?.localizedDescription)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
                
            case .failed:
                print("💩💩💩💩failed")
                //交易失败
                ZKProgressHUD.dismiss()
                ZKProgressHUD.showError(transaction.error?.localizedDescription)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            default:
                break
            }
        }
        
        buyManage.callBackProductErrorBlock = {
            DispatchQueue.main.async {
                ZKProgressHUD.dismiss()
                ZKProgressHUD.showError("Purchase Failed")
            }
        }
        
        var iapList: [String] = []
        for mode in arrayData {
            iapList.append(mode.iapid ?? "")
        }
        
        buyManage.retrieveProductsInfo(iapList: iapList) { result in
            
            if let r = result {
                for model in self.arrayData {
                    for m in r {
                        model.zhenPrice = m.localizedPrice
                    }
                }
            }
            self.storeColltionView.reloadData()
        }

    }
    
    
     
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    let arrayData = StoreItemModal.createDataArray()
    lazy var storeColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let colltionView = UICollectionView.init(frame: CGRectMake(20, titleLabel.bottom+10, Screen_width-40, Screen_height-titleLabel.bottom-10), collectionViewLayout: layout)
        colltionView.backgroundColor = .clear
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView.delegate = self;
        colltionView.dataSource = self;
        let left: CGFloat = 24
        let padding: CGFloat = 15
        let cellWidth: CGFloat = (UIScreen.main.bounds.size.width - left * 2 - padding - 1) / 2
        layout.itemSize = CGSize.init(width: cellWidth, height: 108)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        return colltionView
        
    }()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let model: StoreItemModal = arrayData[indexPath.row]
        cell.layer.contents = UIImage.init(named:"store_background")?.cgImage;
        
        cell.contentView.removeAllSubviews()
        
        let image = UIImageView.init()
        image.frame = CGRect.init(x: 30, y: 27, width: 25 , height: 17)
        image.backgroundColor = .clear
        image.image = UIImage.init(named: "popup_coins_cost")
        
        let label = UILabel.init()
        label.frame = CGRect.init(x: image.right, y: 10, width: 60 , height: 50)
        label.textAlignment = .center
        label.text = "X\(model.consCount ?? "")"
        label.font = GetMyFont(18, "Comic Sans MS Bold")
        label.textColor = .white
        
        let dollar = UILabel.init()
        dollar.frame = CGRect.init(x: 10, y: cell.height-40, width: cell.width-20 , height: 40)
        dollar.textAlignment = .center
        dollar.text = "\(model.price ?? "")"
        dollar.font = GetMyFont(18, "Comic Sans MS Bold")
        dollar.textColor = .white
        
        cell.contentView.addSubview(image)
        cell.contentView.addSubview(label)
        cell.contentView.addSubview(dollar)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model: StoreItemModal = arrayData[indexPath.row]
        buyIcon(model: model)
    }
    
    func netWorkError() {
        let alert = UIAlertController(title: "NetWork Error", message: "The network is not reachable. Please reconnect to continue using the app.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        alert.addAction(okButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func buyIcon(model: StoreItemModal) {

//        let status = CoreStatus.currentNetWorkString()
//        if status == "无网络" || status == "未知网络" || status == "2G" {
//            self.netWorkError()
//        }else{
//            ZKProgressHUD.show()
//            self.currentBuyModel = model
//            self.validateIsCanBought(iapID: model.iapid!)
//        }
        let netManager = NetworkReachabilityManager()
        netManager?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .notReachable :
                self.netWorkError()
                break
            case .unknown :
                self.netWorkError()
                break
            case .reachable(_):
                
                ZKProgressHUD.show()
                self.currentBuyModel = model
                self.buyManage.validateIsCanBought(iapID: model.iapid!)
                break
            }
        })
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let productsArr = response.products
        
        if productsArr.count == 0 {
            
            DispatchQueue.main.async {
                ZKProgressHUD.dismiss()
                ZKProgressHUD.showError("Purchase Failed")
            }
            
            return
        }
        
        let payment = SKPayment.init(product: productsArr[0])
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        DispatchQueue.main.async { [self] in
            for transaction in transactions {
                switch transaction.transactionState {
                case .purchased:
                    print("💩💩💩💩purchased")
                    ZKProgressHUD.dismiss()
                    // 购买成功
                    SKPaymentQueue.default().finishTransaction(transaction)
                    if let model = self.currentBuyModel {
                        var price = model.zhenPrice!.count > 0 ? model.zhenPrice : model.price
                        price!.remove(at: price!.startIndex)
                        diamondsLabel.text = "\(buyStore(price:model.consCount!))"
                    }
                    break
                    
                case .purchasing:
                    print("💩💩💩💩purchasing")
                    break
                    
                case .restored:
                    print("💩💩💩💩restored")
                    ZKProgressHUD.dismiss()
                    ZKProgressHUD.showError(transaction.error?.localizedDescription)
                    SKPaymentQueue.default().finishTransaction(transaction)
                    break
                    
                case .failed:
                    print("💩💩💩💩failed")
                    //交易失败
                    ZKProgressHUD.dismiss()
                    ZKProgressHUD.showError(transaction.error?.localizedDescription)
                    SKPaymentQueue.default().finishTransaction(transaction)
                    break
                default:
                    break
                }
            }
        }
    }
    
    func validateIsCanBought(iapID: String) {
        buyProductInfo(iapID: iapID)
    }
    
    func buyProductInfo(iapID: String) {
        let result = SKProductsRequest.init(productIdentifiers: [iapID])
        result.delegate = self
        result.start()
    }
    deinit {
        removeObserver()
        buyManage.removeObserver()
    }
    
    func removeObserver() {
        SKPaymentQueue.default().remove(self)
    }
    
    func addObserver() {
        SKPaymentQueue.default().add(self)
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // TODO: 创建查询条件
    class func createQuaryMutableDictionary(identifier:String)->NSMutableDictionary{
        // 创建一个条件字典
        let keychainQuaryMutableDictionary = NSMutableDictionary.init(capacity: 0)
        // 设置条件存储的类型
        keychainQuaryMutableDictionary.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        // 设置存储数据的标记
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrService as String)
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrAccount as String)
        // 设置数据访问属性
        keychainQuaryMutableDictionary.setValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
        // 返回创建条件字典
        return keychainQuaryMutableDictionary
    }
    
    // TODO: 存储数据
    class func keyChainSaveData(data:Any ,withIdentifier identifier:String)->Bool {
        // 获取存储数据的条件
        let keyChainSaveMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 删除旧的存储数据
        SecItemDelete(keyChainSaveMutableDictionary)
        // 设置数据
        keyChainSaveMutableDictionary.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        // 进行存储数据
        let saveState = SecItemAdd(keyChainSaveMutableDictionary, nil)
        if saveState == noErr  {
            return true
        }
        return false
    }
    
    // TODO: 更新数据
    class func keyChainUpdata(data:Any ,withIdentifier identifier:String)->Bool {
        // 获取更新的条件
        let keyChainUpdataMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 创建数据存储字典
        let updataMutableDictionary = NSMutableDictionary.init(capacity: 0)
        // 设置数据
        updataMutableDictionary.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        // 更新数据
        let updataStatus = SecItemUpdate(keyChainUpdataMutableDictionary, updataMutableDictionary)
        if updataStatus == noErr {
            return true
        }
        return false
    }
    
    
    // TODO: 获取数据
    class func keyChainReadData(identifier:String)-> Any {
        var idObject:Any?
        // 获取查询条件
        let keyChainReadmutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 提供查询数据的两个必要参数
        keyChainReadmutableDictionary.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keyChainReadmutableDictionary.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        // 创建获取数据的引用
        var queryResult: AnyObject?
        // 通过查询是否存储在数据
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadmutableDictionary, UnsafeMutablePointer($0))}
        if readStatus == errSecSuccess {
            if let data = queryResult as! NSData? {
                idObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as Any
            }
        }
        if (idObject == nil) {
            return 0
        }
        return idObject as Any
    }
    
}

class StoreItemModal: NSObject {
    
    var price: String?
    var zhenPrice: String?
    var iapid: String?
    var consCount: String?
    var displayname: String?
    
    class func createDataArray() -> Array<StoreItemModal> {
        let path = Bundle.main.path(forResource: "StoreItem", ofType: "plist")
        let array = NSArray(contentsOfFile: path!) as! Array<Dictionary<String, String>>
        var arrayData: Array<StoreItemModal> = []
        for dic in array {
            let model = StoreItemModal()
            model.price = dic["price"]
            model.iapid = dic["iapid"]
            model.consCount = dic["coinsCount"]
            model.displayname = dic["displayname"]
            model.zhenPrice = ""
            arrayData.append(model)
        }
        return arrayData
    }
}
