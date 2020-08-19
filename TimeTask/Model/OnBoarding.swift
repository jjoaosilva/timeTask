//
//  OnBoarding.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 19/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

// swiftlint:disable line_length

struct Onboard {
    var image: String
    var subtitle: String
    var buttonTitle: String

    static func mockOnboard() -> [Onboard] {
        return [
            Onboard(image: "page01Onboarding", subtitle: "Adicione suas tarefas", buttonTitle: "Próximo"),
            Onboard(image: "page02Onboarding", subtitle: "Organize seu tempo", buttonTitle: "Próximo"),
            Onboard(image: "page03Onboarding", subtitle: "Ao fim, conclua suas tarefas no seu ritmo", buttonTitle: "Começar")
        ]
    }
}
