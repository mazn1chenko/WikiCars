//
//  TabBarViewController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

enum Tabs: Int{
    
    case main
    case news
    case settings
    
}

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTabBar()

    }
    
    func settingsTabBar(){
        
        tabBar.backgroundColor = .yellow
                
        let mainPageViewController = MainPageViewController()
        let newsPageViewController = NewsPageViewController()
        let settingsPageViewController = SettingsPageViewController()
        
        let mainPageNavigationController = NavigationBarController(rootViewController: mainPageViewController)
        let newsPageNavigationController = NavigationBarController(rootViewController: newsPageViewController)
        let settingsPageNavigationController = NavigationBarController(rootViewController: settingsPageViewController)
        
        mainPageNavigationController.tabBarItem = UITabBarItem(title: "WikiCars", image: UIImage(named: "mainPage"), tag: Tabs.main.rawValue)
        newsPageNavigationController.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "newsPage"), tag: Tabs.news.rawValue)
        settingsPageNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settingsPage"), tag: Tabs.settings.rawValue)
        
        
        setViewControllers([newsPageNavigationController, mainPageNavigationController, settingsPageNavigationController], animated: false)
    }

}
