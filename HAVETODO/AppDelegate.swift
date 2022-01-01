//
//  AppDelegate.swift
//  HAVETODO
//
//  Created by 장효원 on 2021/11/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orientation = UIInterfaceOrientationMask.portrait //세로모드 고정

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //iOS 15 UITableView 헤더 대응
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        
        return true
    }

    //세로 고정시 사용
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        return orientation
    }
}

