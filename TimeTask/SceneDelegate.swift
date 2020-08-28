//
//  SceneDelegate.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 13/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

// swiftlint:disable unused_optional_binding line_length

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windownScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windownScene.coordinateSpace.bounds)
        window?.windowScene = windownScene

        window?.rootViewController = Router.maincController()
        window?.makeKeyAndVisible()

        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
