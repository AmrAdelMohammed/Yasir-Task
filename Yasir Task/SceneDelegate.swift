//
//  SceneDelegate.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let homeVC = HomeViewController()
            let navController = UINavigationController(rootViewController: homeVC)
            
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
    }
    
}

