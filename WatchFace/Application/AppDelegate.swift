//
//  AppDelegate.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SideMenu
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let leftMenuNavigationController = LeftMenuBuilder().build()
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController as? SideMenuNavigationController
        
        if #available(iOS 13, *) {

        } else {
            window = UIWindow()
            
            let vc = WatchFacesListBuilder().build()
            let nvc = UINavigationController(rootViewController: vc)
            
            window?.rootViewController = nvc
            window?.makeKeyAndVisible()
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
}

