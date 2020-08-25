//
//  ManageTaskDelegate.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 22/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import Foundation

protocol ManageTaskDelegate: class {
    func manageTask(indexPath: IndexPath, task: Task)
}
