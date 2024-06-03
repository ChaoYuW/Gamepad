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
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        // 设置button的其他属性
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .orange
        
        self.view.addSubview(self.myButton)
    }
    
    @objc func buttonTapped() {
            // 按钮点击事件处理
        
        self.navigationController?.pushViewController(ScanListViewController(), animated: false)
        }

}
