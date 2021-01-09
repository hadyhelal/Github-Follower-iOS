//
//  SceneDelegate.swift
//  Mini GitHub
//
//  Created by Hady on 10/30/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene      = (scene as? UIWindowScene) else { return }

        window                     = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene        = windowScene
        window?.rootViewController = creatTabBar()
        window?.makeKeyAndVisible()
        configureNavigationBar()
    }
    
    func creatSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteListVC() -> UINavigationController {
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorites"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
    
    func creatTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [creatSearchNC() , createFavoriteListVC()]
        
        return tabbar
    }

    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
