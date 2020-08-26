//
//  HistoricViewController.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 25/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast line_length

class HistoricViewController: UIViewController {

    var allTasks: [HistoricTasks] = [HistoricTasks]()

    lazy var tablewView: HistoricView = {
        let historicView = HistoricView()
        historicView.tableView.delegate = self
        historicView.tableView.dataSource = self
        return historicView
    }()

    var date: String = {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }()

    override func viewWillAppear(_ animated: Bool) {
        getTasks()
        self.tablewView.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        self.view = tablewView
    }

    private func getTasks() {
        if let alltasks = ManageFileTasks.readTasksDataFromFile() {
            self.allTasks = alltasks
        }
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .systemBackground
        self.title = "Historic"
    }
}

extension HistoricViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allTasks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.allTasks[section].tasks.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.allTasks[section].date == self.date {
            return "Today"
        }
        return self.allTasks[section].date
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
        cell.configure(with: allTasks[indexPath.section].tasks[indexPath.row], indexPath: indexPath, isEditable: false)

        return cell
    }
}
