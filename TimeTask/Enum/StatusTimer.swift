//
//  StatusTimer.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 21/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation
import UIKit

enum StatusTimer {
    case start
    case pause
    case resume

    var color: UIColor {
        switch self {
        case .pause:
            return UIColor.systemYellow
        case .start, .resume:
            return UIColor.systemGreen
        }
    }

    var tappedColor: UIColor {
        switch self {
        case .pause:
            return UIColor(red: 0.89, green: 0.71, blue: 0.00, alpha: 1.00)
        case .start, .resume:
            return UIColor(red: 0.27, green: 0.75, blue: 0.35, alpha: 1.00)
        }
    }

    var name: String {
        switch self {
        case .pause:
            return "Pause"
        case .resume:
            return "Resume"
        case .start:
            return "Start"
        }
    }
}
