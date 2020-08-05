//
//  AppDelegate.swift
//  ReadOcean
//
//  Created by ruruzi on 2020/5/20.
//  Copyright © 2020 HAM02020. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = YDMainViewController()
        window?.makeKeyAndVisible()
        
//        if #available(iOS 13.0, *) {
//          let appearance = UINavigationBarAppearance()
//          appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor.init(hexString: "#706EDB")  // adjusted to match the translucent version
//          appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//          appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//          UINavigationBar.appearance().standardAppearance = appearance
//          UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        } else {
//          UINavigationBar.appearance().tintColor = .white
//          UINavigationBar.appearance().barTintColor = .red
//          UINavigationBar.appearance().isTranslucent = true
//        }
        
        
        return true
    }


}

