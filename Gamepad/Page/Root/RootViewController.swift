//
//  RootViewController.swift
//  Gamepad
//
//  Created by chao on 2024/6/3.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {
    
    
    
    // 懒加载的UIButton
    lazy var myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("点击我", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // 设置button的其他属性
        return button
    }()
    lazy var handleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("手柄", for: .normal)
        button.frame = CGRect(x: CGRectGetMaxX(self.myButton.frame)+100
                              , y: 100, width: 100, height: 50)
        button.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
        // 设置button的其他属性
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .orange
        
        self.view.addSubview(self.myButton)
        self.myButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            
        }
        self.view.addSubview(self.handleButton)
        self.handleButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
            make.top.equalTo(self.myButton.snp_bottomMargin).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            
        }
    }
    
    @objc func buttonTapped() {
            // 按钮点击事件处理
        
        self.navigationController?.pushViewController(ScanListViewController(), animated: false)
        }
    @objc func handleTapped() {
        self.navigationController?.pushViewController(HandleViewController(), animated: false)
    }

}
