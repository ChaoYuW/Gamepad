//
//  ControlButton.swift
//  Gamepad
//
//  Created by chao on 2024/6/7.
//

import UIKit
import AudioToolbox


public enum ControlType {
    case back
    case start
    case a
    case b
    case x
    case y
}


typealias ButtonActionHandler<Bool> = ((Bool) -> Void)

class ControlButton: UIView {

    
    var title:String = ""
    var font:UIFont = UIFont.systemFont(ofSize: 15.0)
    var normalBackgroundColor :UIColor = ColorUtils.hexStringToUIColor(hex: "#303032")
    var selectBackgroundColor :UIColor = ColorUtils.hexStringToUIColor(hex: "#0383FF")
    
//    var tapedAction = (tag) -> 
    var buttonActionHandler: ButtonActionHandler<Bool>?
    
    public typealias LLdidSelectItemAtIndexClosure = (NSInteger) -> Void
    
    var vibrate:Bool = false
    
    var vibrateState:Bool{
        get{
            return vibrate
        }
        set(newValue){
            vibrate = newValue
        }
    }
    
    
    var normalColor:UIColor{
        get
        {
            return normalBackgroundColor
        }
        set(newValue){
            normalBackgroundColor = newValue
        }
    }
    var selectColor:UIColor{
        get
        {
            return selectBackgroundColor
        }
        set(newValue){
            selectBackgroundColor = newValue
        }
    }
    
    lazy var itemButton = {
        let view = self.getButton(title: self.title, font: self.font)
        return view
    }()
    
    
    init(frame:CGRect,title:String){
        super.init(frame: frame)
        self.title = title
        
    }
    init(frame:CGRect,title:String,font:UIFont){
        super.init(frame: frame)
        self.title = title
        self.font = font
        self.initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.initUI()
    
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.initUI()
//
//    }
    
    func initUI(){
        self.addUI()
        self.addLayout()
    }

    func addUI(){
        
        self.addSubview(self.itemButton)
        
        self.itemButton.backgroundColor = self.normalColor

    }
    func addLayout(){
        self.itemButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.tapedClick()
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.releasedClick()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        
        if self.point(inside: point, with: nil){
            self.tapedClick()
        }else{
            self.releasedClick()
        }
    }
    
    func tapedClick(){
        self.itemButton.backgroundColor = self.selectColor
        
        if(self.vibrate){
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        if(self.buttonActionHandler != nil){
            self.buttonActionHandler!(true)
        }
        
        
    }
    func releasedClick(){
        self.itemButton.backgroundColor = self.normalColor
        
        if(self.buttonActionHandler != nil){
            self.buttonActionHandler!(false)
        }
    }
    
    // 注册回调方法
    func registerActionHandler(_ handler:@escaping ButtonActionHandler<Bool>){
        self.buttonActionHandler = handler
    }
    
    
    @objc func buttonTapped() {
        self.itemButton.backgroundColor = self.selectColor
        }
    @objc func buttonReleased() {
        self.itemButton.backgroundColor = self.normalColor
        }
    
    
    func getButton(title:String,font:UIFont) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchCancel])
        return button
    }
    
    func getABButton(title:String,font:UIFont) ->UIButton{
        let button = self.getButton(title: title, font: font)
        return button
    }
}
