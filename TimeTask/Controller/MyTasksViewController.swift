//
//  MyTasksViewController.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 17/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit
// swiftlint:disable force_cast line_length

class MyTasksViewController: UIViewController {

    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    let noneTask: NoneTaskView = {
        var noneTask = NoneTaskView()
        noneTask.translatesAutoresizingMaskIntoConstraints = false

        return noneTask
    }()

    var characters: [Task] = [Task(activity: "Do 01 Screen", description: "Do this screen 1 =(", check: false),
                      Task(activity: "Do 02 Screen", description: "Do this screen 2 =(", check: false),
                      Task(activity: "Do 03 Screen", description: "Do this screen 3 =(", check: false),
                      Task(activity: "Do 04 Screen", description: "Do this screen 4 =(", check: false),
                      Task(activity: "Do 05 Screen", description: "Do this screen 5 =(", check: false)
        ] {
        didSet {
            configureView()
        }
    }

    override func loadView() {
        super.loadView()
        setup()
        setupLayout()
        setupNavigationBar()
        configureView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .systemBackground
        self.title = "My tasks"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskButtonWasTapped))
    }

    private func configureView() {
        let isEmpty = characters.isEmpty

        self.tableView.isHidden = isEmpty
        self.noneTask.isHidden = !isEmpty
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),

            noneTask.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            noneTask.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    private func setup() {
        view.addSubview(tableView)
        view.addSubview(noneTask)

        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.allowsSelection = true
    }

    private func deleteTask(indexPath: IndexPath) {
        tableView.beginUpdates()
        characters.remove(at: indexPath.row )
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }

    @objc func addTaskButtonWasTapped() {
        let newTask = NewtaskViewController()
        newTask.delegate = self

        let navController = UINavigationController(rootViewController: newTask)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }

}

extension MyTasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
        cell.configure(with: characters[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timeTask = TimeTaskViewController()

        timeTask.titleTask = characters[indexPath.row].activity
        timeTask.descriptionTask = characters[indexPath.row].description
        self.navigationController?.pushViewController(timeTask, animated: true)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(indexPath: indexPath)
        }
    }

}

extension MyTasksViewController: NewTaskDelegate {
    func createNewTask(create with: Task) {
        self.tableView.beginUpdates()
        self.characters.insert(with, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
        self.tableView.endUpdates()
    }
}
