//
//  ControlButton.swift
//  Gamepad
//
//  Created by chao on 2024/6/7.
//

import UIKit
import AudioToolbox

class ControlButton: UIView {

    
    var title:String = ""
    var font:UIFont = UIFont.systemFont(ofSize: 15.0)
    var normalBackgroundColor :UIColor = ColorUtils.hexStringToUIColor(hex: "#303032")
    var selectBackgroundColor :UIColor = ColorUtils.hexStringToUIColor(hex: "#0383FF")
    
//    var tapedAction = (tag) -> 
    var releasedAction: Selector?
    
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
        self.itemButton.backgroundColor = self.selectColor
        
        if(self.vibrate){
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
//        if(self.tapedAction != nil){
//            self.tapedAction
//        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.itemButton.backgroundColor = self.normalColor
    }
    
    
    lazy var itemButton = {
        let view = self.getButton(title: self.title, font: self.font)
        return view
    }()
    
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
