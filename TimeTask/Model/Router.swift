//
//  Router.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 27/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

struct Router {
    static func maincController() -> UIViewController {
        let hasSeenOnboard = UserDefaults.standard.bool(forKey: "hasSeenOnboard") // Feedback: ler um pouco sobre router

        if !hasSeenOnboard {
            return OnboardingViewController()
        } else {
            return TabBarController()
        }
    }
}
