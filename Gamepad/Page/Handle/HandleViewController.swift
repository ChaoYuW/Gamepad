//
//  HandleViewController.swift
//  Gamepad
//
//  Created by chao on 2024/6/5.
//

import UIKit

class HandleViewController: UIViewController {
    
    
    var bleHelper = BlueToothHelper.shared

    
    lazy var fcHandleView: FCHandleView = {
        
        let view = FCHandleView(frame: self.view.frame)
        view.registerSenderHandler{  [weak self] gamePadState in
            self?.senderData(data: gamePadState)
        }
        return view
    }()
    
    lazy var gbaHandleView :GBAHandleView = {
        let view = GBAHandleView(frame: self.view.frame)
        return view
    }()
    
    lazy var menuView:UIView = {
        let view = UIView()
        return view
    }()
    lazy var selectButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("手柄选择", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        button.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C")
        return button
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "DangerIcon"), for: .normal)
        button.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C")
        return button
    }()
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "ExportIcon"), for: .normal)
        button.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#7C7C7C")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.initUI()
        
        
    }
    
    func initUI(){
        self.addUI()
        self.addLayout()
    }
    func addUI(){
        
        self.view.addSubview(self.gbaHandleView)
        self.view.addSubview(self.fcHandleView)

        self.menuView.addSubview(self.leftButton)
        self.menuView.addSubview(self.selectButton)
        self.menuView.addSubview(self.rightButton)
        self.view.addSubview(self.menuView)
        
        self.gbaHandleView.isHidden = true
        self.fcHandleView.isHidden = false
    }
    func addLayout(){
        
        self.leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        self.selectButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(49)
        }
        self.rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        self.menuView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    
    func senderData(data:GamePadState){
        BlueToothHelper.shared.sendData(data: data)
    }

   @objc func handleSelect(){
       
       
       let alertController = UIAlertController(title: "手柄选择", message: nil, preferredStyle: .actionSheet)
       
       let action1 = UIAlertAction(title: "FC手柄", style: .default) { (acction) in
           self.gbaHandleView.isHidden = true
           self.fcHandleView.isHidden = false
       }
       let action2 = UIAlertAction(title: "GBA手柄", style: .default) { (acction) in
           self.gbaHandleView.isHidden = false
           self.fcHandleView.isHidden = true
       }
//       let action3 = UIAlertAction(title: "街机手柄", style: .default) { (acction) in
//           
//       }
       alertController.addAction(action1)
       alertController.addAction(action2)
//       alertController.addAction(action3)
       
       if let rootController = UIApplication.shared.windows.first(where: { $0.isKeyWindow }){
           present(alertController, animated: true)
       }
   }
}
