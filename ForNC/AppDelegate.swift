//
//  AppDelegate.swift
//  ForNC
//
//  Created by Ace Young on 2019/11/21.
//  Copyright © 2019 Ace Young. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let nav = AYNavigationController(rootVC: FirstViewController(), style: .defaultStyle)
        nav.isPresented = true
        let tab = UITabBarController()
        tab.viewControllers = [nav]
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
        return true
    }
}

