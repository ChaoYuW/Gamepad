//
//  FCHandleView.swift
//  Gamepad
//
//  Created by chao on 2024/6/5.
//

import UIKit

class FCHandleView: UIView {
    
    private var gamePadState:GamePadState = GamePadState()
    var senderHandler: SenderHandler<GamePadState>?
    
    lazy var handleItem: HandleItem = {
        let view = HandleItem(frame: CGRect(x: 400, y: 300, width: 200, height: 200))
        return view
    }()
    
    lazy var backButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "BACK", font: UIFont.systemFont(ofSize: 15.0))
        button.registerActionHandler { select in
            
            self.gamePadState.back = select
            self.send()
        }
        return button
    }()
    lazy var startButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "START", font: UIFont.systemFont(ofSize: 15.0))
        button.registerActionHandler { select in
            
            self.gamePadState.start = select
            self.send()
        }
        return button
    }()
    lazy var aButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "A", font: UIFont.boldSystemFont(ofSize: 36))
        button.registerActionHandler { select in
            
            self.gamePadState.a = select
            self.send()
        }
        button.vibrate = true
        return button
    }()
    lazy var bButton: ControlButton = {
        let button = ControlButton.init(frame: CGRectZero, title: "B", font: UIFont.boldSystemFont(ofSize: 36))
        button.registerActionHandler { select in
            
            self.gamePadState.b = select
            self.send()
        }
        button.vibrate = true
        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.initUI()
    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initUI()

    }
    
    func initUI(){
        self.addUI()
        self.addLayout()
    }
    
    func addUI(){
        self.backgroundColor = UIColor.black
        
        self.addSubview(self.backButton)
        self.addSubview(self.startButton)
        
        self.addSubview(self.aButton)
        self.addSubview(self.bButton)
        
        self.addSubview(self.handleItem)
    }
    func addLayout(){
        
        self.backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview().offset(-(25+30))
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.startButton.snp.makeConstraints { make in
//            make.top.equalTo(self.backButton.snp_topMargin)
            make.centerY.equalTo(self.backButton.snp_centerYWithinMargins)
            make.left.equalTo(self.backButton.snp_rightMargin).offset(48)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.bButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-80)
            make.centerY.equalTo(self.handleItem.snp_centerYWithinMargins)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.aButton.snp.makeConstraints { make in
            make.right.equalTo(self.bButton.snp_leftMargin).offset(-60)
            make.centerY.equalTo(self.bButton.snp_centerYWithinMargins)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.handleItem.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(91)
            make.bottom.equalToSuperview().offset(-35)
            make.size.equalTo(168)
        }
    }
    
    @objc func backClicked() {
        
    }
    @objc func aClicked() {
    }
    @objc func bClicked() {

    }
    func send(){
        if(self.senderHandler != nil){
            self.senderHandler!(self.gamePadState)
        }
        
    }
    // 注册回调方法
    func registerSenderHandler(_ handler:@escaping SenderHandler<GamePadState>){
        self.senderHandler = handler
    }
    
    
}
