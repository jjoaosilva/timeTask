//
//  TabBarController.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 25/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var myTasks: UIViewController = {
        let navigation = UINavigationController()
        navigation.navigationBar.barTintColor = .systemBackground
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.shadowImage = UIImage()

        let mainViewController = MyTasksViewController()
        navigation.viewControllers = [mainViewController]
        navigation.tabBarItem = UITabBarItem(title: "My tasks", image: UIImage(systemName: "list.bullet"), tag: 0)

        return navigation
    }()

    var historic: UIViewController = {
        let navigation = UINavigationController()
        navigation.navigationBar.barTintColor = .systemBackground
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.shadowImage = UIImage()

        let mainViewController = HistoricViewController()
        navigation.viewControllers = [mainViewController]
        navigation.tabBarItem = UITabBarItem(title: "Historic", image: UIImage(systemName: "archivebox"), tag: 1)

        return navigation
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTabBar()
    }

    private func configurateTabBar() {
        let tabBarList = [myTasks, historic]

        self.viewControllers = tabBarList
    }
}
