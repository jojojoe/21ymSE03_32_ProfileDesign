//
//  CommonUIFoundation.swift
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

import Foundation
import UIKit
import Photos


//MARK: ---公共方法---
/// RGB值获取颜色
///
/// - Parameters:
///   - red: 红
///   - gren: 绿
///   - blue: 蓝
///   - alpha: 透明度
/// - Returns: UIColor
public func MyColorFunc(_ red:CGFloat,_ gren:CGFloat,_ blue:CGFloat,_ alpha:CGFloat) -> UIColor? {
    let color:UIColor = UIColor(red: red/255.0, green: gren/255.0, blue: blue/255.0, alpha: alpha)
    return color
}

//获取字体
public func GetMyFont(_ fontSize:CGFloat,_ name:String = "") -> UIFont {
    
    if name.isEmpty {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    if let font = UIFont(name: name, size: fontSize) {
        return font
    }
    
    return UIFont.systemFont(ofSize: fontSize)
}

public func CGRectMake(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) -> CGRect{
    return CGRect(x: x, y: y, width: width, height: height)
}


let FSAppdelegate = UIApplication.shared.delegate as! AppDelegate

//MARK: --公共UI宏定义--
let Screen_width = UIScreen.main.bounds.size.width
let Screen_height = UIScreen.main.bounds.size.height
let StatusBarHeightX: CGFloat = Screen_height >= 780 ? 44.0:20.0
let VERSION = Double(UIDevice.current.systemVersion)
let Screen_safeArea:CGFloat = Screen_height >= 780 ? 34.0:0
let ScaleWidth:CGFloat = UIScreen.main.bounds.size.width / 375.0
let ScaleHeightScale:CGFloat = UIScreen.main.bounds.size.height / 667.0
let xNavStatusHeight = UIApplication.shared.statusBarFrame.size.height + 44    //获取导航栏及状态栏的高度

// MARK: --公共UI颜色--
let FSCommonVCBGColor:UIColor = MyColorFunc(238, 238, 238, 1.0)! //公共背景色
//MARK: --公共字体颜色--
let FSCommonTextColorTitle:UIColor = MyColorFunc(27, 27, 27, 1.0)!//浅灰色字体颜色
let FSBUttonColor:UIColor = MyColorFunc(51, 51, 51, 1.0)!

let balanceKey = "balance"


func getColorData() -> NSMutableArray{
    let colorArr = NSMutableArray.init()
    colorArr.add(UIColor.white)
    colorArr.add(MyColorFunc(187, 36, 108, 1.0)!)
    colorArr.add(MyColorFunc(193, 37, 72, 1.0)!)
    colorArr.add(MyColorFunc(217, 53, 89, 1.0)!)
    colorArr.add(MyColorFunc(196, 52, 96, 1.0)!)
    colorArr.add(MyColorFunc(194, 92, 105, 1.0)!)
    colorArr.add(MyColorFunc(234, 117, 141, 1.0)!)
    colorArr.add(MyColorFunc(229, 128, 132, 1.0)!)
    colorArr.add(MyColorFunc(208, 131, 108, 1.0)!)
    colorArr.add(MyColorFunc(230, 136, 143, 1.0)!)
    colorArr.add(MyColorFunc(207, 140, 144, 1.0)!)
    colorArr.add(MyColorFunc(242, 174, 186, 1.0)!)
    colorArr.add(MyColorFunc(240, 174, 163, 1.0)!)
    colorArr.add(MyColorFunc(246, 210, 203, 1.0)!)
    colorArr.add(MyColorFunc(231, 138, 164, 1.0)!)
    colorArr.add(MyColorFunc(217, 80, 104, 1.0)!)
    colorArr.add(MyColorFunc(212, 42, 36, 1.0)!)
    colorArr.add(MyColorFunc(195, 39, 37, 1.0)!)
    colorArr.add(MyColorFunc(139, 31, 53, 1.0)!)
    colorArr.add(MyColorFunc(86, 29, 47, 1.0)!)
    colorArr.add(MyColorFunc(165, 104, 119, 1.0)!)
    colorArr.add(MyColorFunc(221, 85, 53, 1.0)!)
    colorArr.add(MyColorFunc(226, 102, 78, 1.0)!)
    colorArr.add(MyColorFunc(224, 104, 38, 1.0)!)
    colorArr.add(MyColorFunc(227, 129, 46, 1.0)!)
    colorArr.add(MyColorFunc(237, 132, 83, 1.0)!)
    colorArr.add(MyColorFunc(239, 175, 113, 1.0)!)
    colorArr.add(MyColorFunc(209, 148, 109, 1.0)!)
    colorArr.add(MyColorFunc(216, 189, 177, 1.0)!)
    colorArr.add(MyColorFunc(205, 179, 145, 1.0)!)
    colorArr.add(MyColorFunc(188, 158, 130, 1.0)!)
    colorArr.add(MyColorFunc(150, 113, 84, 1.0)!)
    colorArr.add(MyColorFunc(86, 51, 35, 1.0)!)
    colorArr.add(MyColorFunc(91, 57, 35, 1.0)!)
    colorArr.add(MyColorFunc(86, 67, 42, 1.0)!)
    colorArr.add(MyColorFunc(241, 151, 41, 1.0)!)
    colorArr.add(MyColorFunc(244, 196, 45, 1.0)!)
    colorArr.add(MyColorFunc(249, 204, 122, 1.0)!)
    colorArr.add(MyColorFunc(249, 220, 166, 1.0)!)
    colorArr.add(MyColorFunc(215, 210, 193, 1.0)!)
    colorArr.add(MyColorFunc(255, 250, 157, 1.0)!)
    colorArr.add(MyColorFunc(254, 246, 105, 1.0)!)
    colorArr.add(MyColorFunc(254, 242, 55, 1.0)!)
    colorArr.add(MyColorFunc(217, 196, 88, 1.0)!)
    colorArr.add(MyColorFunc(187, 178, 101, 1.0)!)
    colorArr.add(MyColorFunc(146, 111, 33, 1.0)!)
    colorArr.add(MyColorFunc(145, 116, 65, 1.0)!)
    colorArr.add(MyColorFunc(159, 203, 48, 1.0)!)
    colorArr.add(MyColorFunc(123, 172, 59, 1.0)!)
    colorArr.add(MyColorFunc(128, 193, 111, 1.0)!)
    colorArr.add(MyColorFunc(109, 141, 95, 1.0)!)
    colorArr.add(MyColorFunc(133, 177, 110, 1.0)!)
    colorArr.add(MyColorFunc(111, 115, 71, 1.0)!)
    colorArr.add(MyColorFunc(82, 79, 37, 1.0)!)
    colorArr.add(MyColorFunc(68, 141, 158, 1.0)!)
    colorArr.add(MyColorFunc(78, 173, 123, 1.0)!)
    colorArr.add(MyColorFunc(25, 161, 110, 1.0)!)
    colorArr.add(MyColorFunc(53, 155, 137, 1.0)!)
    colorArr.add(MyColorFunc(96, 168, 145, 1.0)!)
    colorArr.add(MyColorFunc(18, 126, 88, 1.0)!)
    colorArr.add(MyColorFunc(12, 105, 77, 1.0)!)
    colorArr.add(MyColorFunc(10, 88, 75, 1.0)!)
    colorArr.add(MyColorFunc(14, 114, 110, 1.0)!)
    colorArr.add(MyColorFunc(140, 201, 197, 1.0)!)
    colorArr.add(MyColorFunc(121, 195, 217, 1.0)!)
    colorArr.add(MyColorFunc(61, 182, 204, 1.0)!)
    colorArr.add(MyColorFunc(47, 154, 219, 1.0)!)
    colorArr.add(MyColorFunc(120, 174, 207, 1.0)!)
    colorArr.add(MyColorFunc(143, 186, 198, 1.0)!)
    colorArr.add(MyColorFunc(111, 148, 171, 1.0)!)
    colorArr.add(MyColorFunc(72, 122, 153, 1.0)!)
    colorArr.add(MyColorFunc(57, 114, 150, 1.0)!)
    colorArr.add(MyColorFunc(23, 150, 179, 1.0)!)
    colorArr.add(MyColorFunc(16, 122, 134, 1.0)!)
    colorArr.add(MyColorFunc(11, 96, 117, 1.0)!)
    colorArr.add(MyColorFunc(15, 112, 167, 1.0)!)
    colorArr.add(MyColorFunc(29, 57, 125, 1.0)!)
    colorArr.add(MyColorFunc(25, 59, 130, 1.0)!)
    colorArr.add(MyColorFunc(50, 76, 134, 1.0)!)
    colorArr.add(MyColorFunc(45, 54, 125, 1.0)!)
    colorArr.add(MyColorFunc(87, 104, 154, 1.0)!)
    colorArr.add(MyColorFunc(88, 110, 146, 1.0)!)
    colorArr.add(MyColorFunc(89, 104, 127, 1.0)!)
    colorArr.add(MyColorFunc(21, 77, 113, 1.0)!)
    colorArr.add(MyColorFunc(9, 70, 107, 1.0)!)
    colorArr.add(MyColorFunc(8, 76, 96, 1.0)!)
    colorArr.add(MyColorFunc(6, 61, 89, 1.0)!)
    colorArr.add(MyColorFunc(23, 30, 58, 1.0)!)
    colorArr.add(MyColorFunc(26, 46, 79, 1.0)!)
    colorArr.add(MyColorFunc(58, 60, 86, 1.0)!)
    colorArr.add(MyColorFunc(23, 30, 52, 1.0)!)
    colorArr.add(MyColorFunc(101, 83, 137, 1.0)!)
    colorArr.add(MyColorFunc(110, 78, 142, 1.0)!)
    colorArr.add(MyColorFunc(191, 160, 176, 1.0)!)
    colorArr.add(MyColorFunc(162, 138, 184, 1.0)!)
    colorArr.add(MyColorFunc(142, 120, 154, 1.0)!)
    colorArr.add(MyColorFunc(109, 71, 118, 1.0)!)
    colorArr.add(MyColorFunc(132, 63, 137, 1.0)!)
    colorArr.add(MyColorFunc(93, 34, 91, 1.0)!)
    colorArr.add(MyColorFunc(168, 148, 166, 1.0)!)
    colorArr.add(MyColorFunc(117, 28, 91, 1.0)!)
    colorArr.add(MyColorFunc(193, 100, 153, 1.0)!)
    colorArr.add(MyColorFunc(185, 116, 147, 1.0)!)
    colorArr.add(MyColorFunc(220, 201, 210, 1.0)!)
    colorArr.add(MyColorFunc(130, 115, 131, 1.0)!)
    return colorArr
}

func priceSave() -> Int {
    let _:NSMutableDictionary = StoreViewController.createQuaryMutableDictionary(identifier: balanceKey)
    var balance:Int = StoreViewController.keyChainReadData(identifier: balanceKey) as! Int
    if balance == 0 {
        let save:Bool = StoreViewController.keyChainSaveData(data: 0, withIdentifier: balanceKey)
//        print("\(save ? "存储成功":"存储失败")")
        balance = 0
    }
    return balance
}

func buyStore(price:String) -> Int {
    let balance:Int = StoreViewController.keyChainReadData(identifier: balanceKey) as! Int
    let save:Bool = StoreViewController.keyChainSaveData(data:Int(price)!+balance, withIdentifier: balanceKey)
    print("\(save ? "存储成功":"存储失败")")
    return Int(price)!+balance
}

func createFolder(name:String,baseUrl:NSURL) -> String{
    let manager = FileManager.default
    let folder = baseUrl.appendingPathComponent(name, isDirectory: true)
    print("文件夹: \(String(describing: folder))")
    let exist = manager.fileExists(atPath: folder!.path)
    if !exist {
        try! manager.createDirectory(at: folder!, withIntermediateDirectories: true,
                                     attributes: nil)
    }
    return String(describing: folder)
}

