//
//  AppDelegate.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        navigateToVC()
        
        return true
    }



}

// MARK: Custom Methods
extension AppDelegate {
    
    func navigateToVC() {
        guard let vc = AppStoryboards.mainStoryboard()
            .instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
    }
}
