//
//  AppDelegate.swift
//  Gamepad
//
//  Created by chao on 2024/6/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        self.window?.rootViewController = UINavigationController(rootViewController: RootViewController())
        self.window?.makeKeyAndVisible()
        return true
    }

    func addChildrenController(vcName:String , name:String , imageName:String) -> UINavigationController {

        let VC = swiftClassFromString(className: vcName)
        VC?.title = name
        let navc = UINavigationController(rootViewController: VC!)
        navc.tabBarItem.title = name
        navc.tabBarItem.image = UIImage(named: imageName)
        return navc
    }
    func swiftClassFromString(className: String) -> UIViewController? {
        //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
        //官方文档方法：let myPersonClass: AnyClass? = NSClassFromString("MyGreatApp.Person")
        if  let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
//            let classStringName = "_TtC\(appName.characters.count)\(appName)\(className.characters.count)\(className)"
//            print(classStringName)
            let  cls: AnyClass? = NSClassFromString(className)
            assert(cls != nil, "class not found,please check className")
            if let viewClass = cls as? UIViewController.Type {
                let view = viewClass.init()
                return view
            }
        }
        return nil;
    }


}

