//
//  NewtaskViewController.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 18/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class NewtaskViewController: UIViewController {

// swiftlint:disable line_length

    weak var delegate: NewTaskDelegate?

    let newTaskViewInstance = NewTaskView()

    override func viewDidLoad() {
        super.viewDidLoad()
        getBoredTask()

        self.view = newTaskViewInstance
        consigurateNavigationBar()

    }

    private func getBoredTask() {
        let boredTaskAPI = BoredRequest()

        boredTaskAPI.getBoredTask { result in
            switch result {
            case .success(let task):
                self.newTaskViewInstance.boredTask = task.activity
            case .failure:
                self.newTaskViewInstance.boredTask = "Task"
            }
        }
    }

    private func consigurateNavigationBar() {
        self.title = "New task"
        self.isModalInPresentation = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func done() {
        let task = Task(activity: newTaskViewInstance.titleTask, description: newTaskViewInstance.descriptionTask, check: false)
        delegate?.createNewTask(create: task)
        self.dismiss(animated: true, completion: nil)
    }
}
