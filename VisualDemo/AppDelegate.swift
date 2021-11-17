//
//  AppDelegate.swift
//  VisualDemo
//
//  Created by Rake Yang on 2021/11/16.
//

import UIKit
import CocoaLumberjackSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DDLog.add(DDTTYLogger.sharedInstance!)
        return true
    }


}

