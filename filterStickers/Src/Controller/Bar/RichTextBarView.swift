//
//  RichTextBarView.swift
//  filterStickers
//
//  Created by mac on 2021/10/12.
//

import Foundation
class RichTextBarView: UIView,UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, StickerViewDelegate{
    
    private var _image = UIImage.init()
    var colorDataArr = NSMutableArray()
    var image:UIImage {
        set {
            _image = newValue
        }
        get {
            return _image
        }
    }
    
    var kern:Float = 0
    var fontName:String = "Comic Sans MS Bold"
    var trans:CGFloat = 1
    var textColor:UIColor = MyColorFunc(234, 117, 141, 1.0)!
    
    public var richTextDidChangeBlock:((_ view: StickerView) -> ())!
    
    lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 10, y: StatusBarHeightX, width: 50 , height: 50)
        button.tag = 0
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "test_done_w"), for: .normal)
        button.addTarget(self, action: #selector(rightORwrong(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var wrongButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width-60, y: StatusBarHeightX, width: 50 , height: 50)
        button.tag = 1
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "test_close_w"), for: .normal)
        button.addTarget(self, action: #selector(rightORwrong(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.frame = CGRect(x: 20, y: rightButton.bottom+100, width: Screen_width-40, height:150)
        textView.clipsToBounds = true
        textView.backgroundColor = .clear
        textView.delegate = self
//        let style = NSMutableParagraphStyle()
//        let attributes = [NSAttributedString.Key.font             : GetMyFont(24, "Comic Sans MS Bold"),
//                          NSAttributedString.Key.foregroundColor  : MyColorFunc(234, 117, 141, 1.0) as Any,
//                          NSAttributedString.Key.paragraphStyle   : style,
//                          NSAttributedString.Key.kern             : 10] as [NSAttributedString.Key : Any]
//        let attrStr = NSMutableAttributedString.init(string: "text here", attributes: attributes)
//        textView.attributedText = attrStr
//        textView.textAlignment = .center
        return textView
    }()
    
    lazy var rootView: UIView = {
        let view = UIView.init()
        view.frame = CGRect(x: 0, y: Screen_height-400, width: Screen_width, height:400)
        view.backgroundColor = .white
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasic()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(node:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        changeAttributedText()
    
    }
    
    var buttonArr = NSMutableArray.init()
    
    lazy var keynoteButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: Screen_width/2 , height: 50)
        button.tag = 0
        button.backgroundColor = .white
        button.setTitleColor(FSCommonTextColorTitle, for: .normal)
        button.setTitle("Customize", for: .normal)
        button.titleLabel?.font = GetMyFont(14, "Comic Sans MS Bold")
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: Screen_width/2, y: 0, width: Screen_width/2 , height: 50)
        button.tag = 1
        button.backgroundColor = .white
        button.setTitleColor(MyColorFunc(251, 123, 25, 1.0), for: .normal)
        button.setTitle("Text", for: .normal)
        button.titleLabel?.font = GetMyFont(14, "Comic Sans MS Bold")
        button.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var spaceLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 20, y: keynoteButton.bottom+10, width: 50 , height: 50)
        label.backgroundColor = .clear
        label.textColor = FSCommonTextColorTitle
        label.text = "Space"
        label.font = GetMyFont(12, "Comic Sans MS Bold")
        return label
    }()
    
    lazy var spaceSlider :UISlider = {
        let slider = UISlider.init(frame: CGRect.init(x: spaceLabel.right+20 , y: keynoteButton.bottom+10, width: Screen_width-spaceLabel.right-20-20, height: 50))
        slider.tag = 0
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.value = 0
        slider.isContinuous = true
        slider.transform =  CGAffineTransform.init(scaleX: 1.0, y:1)
            
        slider.minimumTrackTintColor = FSCommonTextColorTitle
        slider.maximumTrackTintColor = FSCommonTextColorTitle
        slider.thumbTintColor = FSCommonTextColorTitle
        
        /// 事件监听
        slider.addTarget(self, action: #selector(sliderDidChange(sender:)), for: .valueChanged)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .normal)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .highlighted)
        
        return slider
        
    }()
    
    lazy var transLabel:UILabel = {
        let label = UILabel.init()
        label.frame = CGRect.init(x: 20, y: spaceLabel.bottom, width: 50 , height: 50)
        label.backgroundColor = .clear
        label.textColor = FSCommonTextColorTitle
        label.text = "Alpha"
        label.font = GetMyFont(12, "Comic Sans MS Bold")
        return label
    }()
    
    
    
    lazy var transSlider :UISlider = {
        let slider = UISlider.init(frame: CGRect.init(x: transLabel.right+20, y: spaceLabel.bottom, width: Screen_width-spaceLabel.right-20-20, height: 50))
        slider.tag = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.isContinuous = true
        slider.transform =  CGAffineTransform.init(scaleX: 1.0, y:1)
            
        slider.minimumTrackTintColor = FSCommonTextColorTitle
        slider.maximumTrackTintColor = FSCommonTextColorTitle
        slider.thumbTintColor = FSCommonTextColorTitle
        
        /// 事件监听
        slider.addTarget(self, action: #selector(sliderDidChange(sender:)), for: .valueChanged)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .normal)
        slider.setThumbImage(UIImage.init(named: "adjust_slide"), for: .highlighted)
        
        return slider
        
    }()
    
    fileprivate func setupBasic(){
        
        colorDataArr = getColorData()
        
        self.addSubview(rightButton)
        self.addSubview(wrongButton)
        self.addSubview(textView)
        self.addSubview(rootView)
        
        rootView.addSubview(keynoteButton)
        rootView.addSubview(textButton)
        rootView.addSubview(transSlider)
        rootView.addSubview(spaceSlider)
        rootView.addSubview(transLabel)
        rootView.addSubview(spaceLabel)
        rootView.addSubview(colorColltionView)
        
        createFontButton()
        colorDataArr = getColorData()
        colorColltionView.reloadData()
        
    }
    var fontNameArr = ["Comic Sans MS Bold",
                       "Creepster-Regular",
                       "DancingScript-Bold",
                       "Lobster-Regular",
                       "Pacifico-Regular",
                       "PermanentMarker-Regular"]
    func createFontButton() {
        for index in 0 ..< fontNameArr.count {
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: Screen_width/CGFloat(fontNameArr.count)*CGFloat(index),
                                       y: transLabel.bottom+20,
                                       width: Screen_width/CGFloat(fontNameArr.count) ,
                                       height: 30)
            button.tag = index
            button.backgroundColor = .white
            button.setTitle("font", for: .normal)
            button.setTitleColor(FSCommonTextColorTitle, for: .normal)
            button.titleLabel?.font = GetMyFont(18, fontNameArr[index])
            button.addTarget(self, action: #selector(changeFontName(button:)), for: .touchUpInside)
            rootView.addSubview(button)
            buttonArr.add(button)
        }
    }
    
    var selectItem: Int = 0
    
    lazy var colorColltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let colltionView = UICollectionView.init(frame: CGRectMake(20, transLabel.bottom+20+30+20, Screen_width-40, 70), collectionViewLayout: layout)
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        colltionView.delegate = self;
        colltionView.dataSource = self;
        colltionView.backgroundColor = .clear
        colltionView.showsVerticalScrollIndicator = false
        colltionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: 40, height: 68)
        return colltionView
    
    }()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 4;
        cell.clipsToBounds = true;
        cell.layer.borderColor = UIColor.black.cgColor;
        
        if selectItem == indexPath.row && selectItem != 0 {
            cell.layer.borderWidth = 2
        }else{
            cell.layer.borderWidth = 0
        }
        
        if indexPath.row == 0{
            cell.backgroundColor = .clear
            cell.layer.contents = UIImage.init(named:"edit_blank")?.cgImage
        }else{
            cell.layer.contents = nil
            cell.backgroundColor = colorDataArr[indexPath.row] as? UIColor
        }
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem = indexPath.row
        textColor = colorDataArr[indexPath.row] as! UIColor
        changeAttributedText()
        self.colorColltionView.reloadData()
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
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {}
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {}
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {}
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {}
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) { }
    
    func stickerViewDidClose(_ stickerView: StickerView) { }
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    @objc func rightORwrong(button:UIButton) {
        
        textView.resignFirstResponder()
        let testLabel = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: Screen_width/3, height: 40))
        let style = NSMutableParagraphStyle()
        let attributes = [NSAttributedString.Key.font             : GetMyFont(24, fontName),
                          NSAttributedString.Key.foregroundColor  : textColor as Any,
                          NSAttributedString.Key.paragraphStyle   : style,
                          NSAttributedString.Key.kern             : kern] as [NSAttributedString.Key : Any]
        let attrStr = NSMutableAttributedString.init(string: textView.text, attributes: attributes)
        testLabel.attributedText = attrStr
        testLabel.textAlignment = .center
        testLabel.numberOfLines = 0
        
        let view = StickerView.init(contentView: testLabel)
        
        view.delegate = self
        view.alpha = trans
        view.tag = button.tag
        view.setImage(UIImage.init(named: "delete")!, forHandler: StickerViewHandler.close)
        view.setImage(UIImage.init(named: "size_adjust")!, forHandler: StickerViewHandler.rotate)
        view.showEditingHandlers = false
        
        if richTextDidChangeBlock != nil{
            richTextDidChangeBlock(view)
        }
        
    }
    
//    var margin:CGFloat = 0
//    @objc func keyboardWillChangeFrame(node : Notification){
//        print(node.userInfo ?? "")
//        let duration = node.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
//        let endFrame = (node.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let y = endFrame.origin.y
//        margin = UIScreen.main.bounds.height - y
////        print("键盘高度",margin)
//        UIView.animate(withDuration: duration) {
//
//        }
//    }
    
    @objc func sliderDidChange(sender: UISlider) {
        
        if sender.tag == 0 {
            kern = sender.value
            changeAttributedText()
        }else if (sender.tag == 1){
            trans = CGFloat(sender.value)
            changeAttributedText()
        }
    }
    
    
    @objc func changeFontName(button:UIButton) {
        
        fontName = fontNameArr[button.tag]
        changeAttributedText()
    }
    
    
    func changeAttributedText() {
        var str = ""
        if textView.text != "" {
            str = textView.text!
        }
        
        let style = NSMutableParagraphStyle()
        let attributes = [NSAttributedString.Key.font             : GetMyFont(24, fontName),
                          NSAttributedString.Key.foregroundColor  : textColor as Any,
                          NSAttributedString.Key.paragraphStyle   : style,
                          NSAttributedString.Key.kern             : kern] as [NSAttributedString.Key : Any]
        let attrStr = NSMutableAttributedString.init(string: str, attributes: attributes)
        textView.attributedText = attrStr
        textView.textAlignment = .center
        textView.alpha = trans
    }
    
    @objc func tapAction(button:UIButton) {
        if button.tag == 0 {
            keynoteButton.setTitleColor(MyColorFunc(251, 123, 25, 1.0), for: .normal)
            textButton.setTitleColor(FSCommonTextColorTitle, for: .normal)
            textView.becomeFirstResponder()
        }else{
            textButton.setTitleColor(MyColorFunc(251, 123, 25, 1.0), for: .normal)
            keynoteButton.setTitleColor(FSCommonTextColorTitle, for: .normal)
            textView.resignFirstResponder()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RichTextBarView {
    func textViewDidChange(_ textView: UITextView) {
        
        let selectedRange = textView.markedTextRange
        let pos = textView.position(from: textView.beginningOfDocument, offset: 0)
        if (selectedRange != nil) && (pos != nil) {
            return
        }
        let limitWords: Int = 50
        
        if textView.text.count >= limitWords {
            textView.text = String(textView.text.prefix(limitWords))
        }
        
        changeAttributedText()
    }
}

