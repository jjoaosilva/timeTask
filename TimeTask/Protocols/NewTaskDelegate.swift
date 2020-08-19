//
//  NewTaskDelegate.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 18/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

protocol NewTaskDelegate: class {
    func createNewTask(create with: (task: String, description: String))
}
