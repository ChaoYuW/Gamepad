//
//  HandleViewController.swift
//  Gamepad
//
//  Created by chao on 2024/6/5.
//

import UIKit

class HandleViewController: UIViewController {

    
    lazy var fcHandleView: FCHandleView = {
        
        let view = FCHandleView(frame: self.view.frame)
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.fcHandleView)
        
    }
    

}
