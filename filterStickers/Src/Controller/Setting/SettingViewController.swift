//
//  SettingViewController.swift
//  filterStickers
//
//  Created by mac on 2021/10/13.
//

import Foundation
import MessageUI

let feedbackEmail: String = "erglnvek@yandex.com"
let AppName: String = "HighPic"

class SettingViewController: UIViewController{
    
    
    lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: 0, width: 50 , height: 50)
        button.tag = 0
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "setting_back"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 0, y: 0, width: 80 , height: 50)
        label.textAlignment = .center
        label.centerX = self.view.centerX
        label.text = "Setting"
        label.font = GetMyFont(18, "Comic Sans MS Bold")
        label.textColor = .white
        return label
    }()
    
    lazy var logoView:UIImageView = {
        let view = UIImageView.init()
        view.frame = CGRectMake(0, 100, 80, 80)
        view.image = UIImage(named: "logo_icon")
        view.centerX = self.view.centerX
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    
    lazy var versionLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 20, y: logoView.bottom+20 , width: Screen_width-40 , height: 30)
        label.textAlignment = .center
        label.centerX = self.view.centerX
        label.text = "Current version: V1.0.0"
        label.font = GetMyFont(18, "NunitoSans")
        label.textColor = .white
        return label
    }()
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        let _:NSMutableDictionary = StoreViewController.createQuaryMutableDictionary(identifier: balanceKey)
        var balance:Int = StoreViewController.keyChainReadData(identifier: balanceKey) as! Int
        if balance == 0 {
            let save:Bool = StoreViewController.keyChainSaveData(data: 0, withIdentifier: balanceKey)
            print("\(save ? "存储成功":"存储失败")")
            balance = StoreViewController.keyChainReadData(identifier: balanceKey) as! Int
        }
        
        self.view.addSubview(rightButton)
        self.view.addSubview(titleLabel)
        
        self.view.addSubview(logoView)
        self.view.addSubview(versionLabel)
        
        let titleArr = ["Feedback","Privacy Policy","Terms of use"]
        
        for index in 0 ..< titleArr.count{
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: 30, y: versionLabel.bottom+50+CGFloat((50*index)), width: Screen_width-60 , height: 50)
            button.tag = index
            button.backgroundColor = .black
            button.setTitle("\(titleArr[index])", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = GetMyFont(14, "NunitoSans")
            button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0, y: 49 , width: button.width , height: 0.5)
            label.backgroundColor = .white
            
            button.addSubview(label)
            self.view.addSubview(button)
        }
    }
    
    @objc func buttonAction(button:UIButton) {
        if button.tag == 0 {
            print("Feedback")
            
            if MFMailComposeViewController.canSendMail() {
//                UIApplication.shared.canOpenURL(URL.init(string: "mailto://erglnvek@yandex.com")!)
                feedback()
            } else {
                let alert = UIAlertController.init(title: "Unable to send mail", message: "Your device has not set up a mailbox. Please set it in the Mail app before attempting to send it.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (alert) in
                }))
                self.present(alert, animated: false, completion: nil)
            }
            
        }else if button.tag == 1{
//            UIApplication.shared.openURL(url: "https://lowly-discussion.surge.sh/")
//            print("Privacy Policy")
            
            let vc = HighLightingViewController(contentUrl: nil)
            vc.pushSaferiVC(url: "https://lowly-discussion.surge.sh/")
             
            
        }else if button.tag == 2{
            
            print("Term of use")
//
            let vc = HighLightingViewController(contentUrl: nil)
            vc.pushSaferiVC(url: "https://www.app-privacy-policy.com/live.php?token=DntvUEAM7kMsBXWszVU9fhNfBBwSEgrM")
            
        }
    }
    
   
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
   func feedback() {
       //首先要判断设备具不具备发送邮件功能
       if MFMailComposeViewController.canSendMail(){
           //获取系统版本号
           let systemVersion = UIDevice.current.systemVersion
           let modelName = UIDevice.current.modelName
           
           let infoDic = Bundle.main.infoDictionary
           // 获取App的版本号
           let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
           // 获取App的名称
           let appName = "\(AppName)"

           
           let controller = MFMailComposeViewController()
           //设置代理
           controller.mailComposeDelegate = self
           //设置主题
           controller.setSubject("\(appName) Feedback")
           //设置收件人
           // FIXME: feed back email
           controller.setToRecipients([feedbackEmail])
           //设置邮件正文内容（支持html）
        controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
           
           //打开界面
        self.present(controller, animated: true, completion: nil)
       }else{
           
       }
   }
   
   //发送邮件代理方法
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       controller.dismiss(animated: true, completion: nil)
   }
}
extension UIDevice {
  
   ///The device model name, e.g. "iPhone 6s", "iPhone SE", etc
   var modelName: String {
       var systemInfo = utsname()
       uname(&systemInfo)
      
       let machineMirror = Mirror(reflecting: systemInfo.machine)
       let identifier = machineMirror.children.reduce("") { identifier, element in
           guard let value = element.value as? Int8, value != 0 else {
               return identifier
           }
           return identifier + String(UnicodeScalar(UInt8(value)))
       }
      
       switch identifier {
           case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iphone 4"
           case "iPhone4,1":                               return "iPhone 4s"
           case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
           case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
           case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
           case "iPhone7,2":                               return "iPhone 6"
           case "iPhone7,1":                               return "iPhone 6 Plus"
           case "iPhone8,1":                               return "iPhone 6s"
           case "iPhone8,2":                               return "iPhone 6s Plus"
           case "iPhone8,4":                               return "iPhone SE"
           case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
           case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
           case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
           case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
           case "iPhone10,3", "iPhone10,6":                return "iPhone X"
           case "iPhone11,2":                              return "iPhone XS"
           case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
           case "iPhone11,8":                              return "iPhone XR"
           case "iPhone12,1":                              return "iPhone 11"
           case "iPhone12,3":                              return "iPhone 11 Pro"
           case "iPhone12,5":                              return "iPhone 11 Pro Max"
           case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
           case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
           case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
           case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
           case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
           case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
           case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
           case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
           case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
           case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
           case "AppleTV5,3":                              return "Apple TV"
           case "i386", "x86_64":                          return "Simulator"
           default:                                        return identifier
       }
   }
}
