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

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTabBar()

    }
    
    func settingsTabBar(){
        
        tabBar.backgroundColor = .gray
                
        let mainPageViewController = MainPageViewController()
        let newsPageViewController = NewsPageViewController()
        let settingsPageViewController = SettingsPageViewController()
        
        let mainPageNavigationController = NavigationBarController(rootViewController: mainPageViewController)
        let newsPageNavigationController = NavigationBarController(rootViewController: newsPageViewController)
        let settingsPageNavigationController = NavigationBarController(rootViewController: settingsPageViewController)
        
        mainPageNavigationController.tabBarItem = UITabBarItem(title: "WikiCars", image: UIImage(named: "mainPage"), tag: Tabs.main.rawValue)
        newsPageNavigationController.tabBarItem = UITabBarItem(title: "Новини", image: UIImage(named: "newsPage"), tag: Tabs.news.rawValue)
        settingsPageNavigationController.tabBarItem = UITabBarItem(title: "Налаштування", image: UIImage(named: "settingsPage"), tag: Tabs.settings.rawValue)
        
        
        setViewControllers([newsPageNavigationController, mainPageNavigationController, settingsPageNavigationController], animated: false)
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if let tabBarItems = tabBar.items {
                for (index, barItem) in tabBarItems.enumerated() {
                    if barItem == item {
                        tabBar.tintColor = UIColor.white
                    } else {
                        tabBarItems[index].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
                    }
                }
            }
        }
    
}
