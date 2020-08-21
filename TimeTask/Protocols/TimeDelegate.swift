//
//  TimeDelegate.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 21/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

protocol TimeDelegate: class {
    func start(with time: Int)
    func pause()
    func resume()
    func cancel()
}
