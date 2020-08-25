//
//  OnBoarding.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 19/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

struct Onboard: Equatable {
    var image: String
    var subtitle: String
    var buttonTitle: String

    static func mockOnboard() -> [Onboard] {
        return [
            Onboard(image: "page01Onboarding", subtitle: "Add your tasks", buttonTitle: "Next"),
            Onboard(image: "page02Onboarding", subtitle: "Organize your time", buttonTitle: "Next"),
            Onboard(image: "page03Onboarding", subtitle: "Complete your tasks at your own pace", buttonTitle: "Start")
        ]
    }
}
