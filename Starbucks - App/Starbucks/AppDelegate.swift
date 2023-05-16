//
//  AppDelegate.swift
//  Starbucks
//
//  Created by Mahammad Afandiyev on 16.05.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        
        let homeVC = HomeViewController()
        let orderVC = OrderViewController()
        let storeVC = StoreViewController()
        let scanVC = ScanViewController()
        let giftVC = GiftViewController()
        
       
        let orderNC = UINavigationController(rootViewController: orderVC)
        let storeNC = UINavigationController(rootViewController: storeVC)
        let scanNC = UINavigationController(rootViewController: scanVC)
        let giftNC = UINavigationController(rootViewController: giftVC)
        
        homeVC.setTabBarItem(title: "Home", ImageName: "house.fill")
        orderVC.setTabBarItem(title: "Order", ImageName: "arrow.up.bin.fill")
        scanVC.setTabBarItem(title: "Scan", ImageName: "qrcode")
        giftVC.setTabBarItem(title: "Gift", ImageName: "gift.fill")
        storeVC.setTabBarItem(title: "Stores", ImageName: "location.fill")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeVC,scanNC,orderNC,giftNC,storeNC]
        tabBarController.tabBar.isTranslucent = false
        window?.rootViewController = tabBarController
        return true
    }
    func makeNavigationController(rootViewController: UIViewController) ->
    UINavigationController {
    let navigationController = UINavigationController (rootViewController:
    rootViewController)
    navigationController.navigationBar.prefersLargeTitles=true
    let attrs = [
        NSAttributedString.Key.foregroundColor: UIColor.label,
    NSAttributedString.Key.font: UIFont.preferredFont (forTextStyle:
            .title1).withTraits(traits: .traitBold)]
        
    navigationController.navigationBar.largeTitleTextAttributes = attrs
        
    return navigationController
    }




}

