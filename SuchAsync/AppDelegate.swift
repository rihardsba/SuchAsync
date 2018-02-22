//
//  AppDelegate.swift
//  SuchAsync
//
//  Created by Rihards Baumanis on 20/02/2018.
//  Copyright © 2018 Chili. All rights reserved.
//

import UIKit
import AsyncDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Deleting the storyboard and starting our own flow of controllers
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}

