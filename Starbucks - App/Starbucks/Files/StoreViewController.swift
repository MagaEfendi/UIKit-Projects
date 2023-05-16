//
//  StoreViewController.swift
//  Starbucks
//
//  Created by Mahammad Afandiyev on 16.05.23.
//

import UIKit

class StoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
    }
    
    func setTabBarItem(title: String, ImageName: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: ImageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        
        
        
    }
    
}
