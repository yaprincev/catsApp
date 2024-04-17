//
//  AppDelegate.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //initializeRootView()
        return true
    }
}

private extension AppDelegate {

    func initializeRootView() {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = MainModuleConfigurator().createMainModule()
        let navi = UINavigationController(rootViewController: controller)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
}
