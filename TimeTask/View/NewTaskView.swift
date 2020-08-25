//
//  NewTaskView.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 18/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast line_length

class NewTaskView: UIView {

    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    var titleTask: String = ""
    var descriptionTask: String = ""

    var teste: Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemBackground
        configure()
        configureLayout()
    }

    var boredTask: String = "Title" {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func setBoredTask(with boredTask: String) {
        self.boredTask = boredTask
    }

    private func configure() {
        self.addSubview(tableView)

        tableView.register(NewTaskTableViewCell.self, forCellReuseIdentifier: NewTaskTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.allowsSelection = false

    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension NewTaskView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewTaskTableViewCell.reuseIdentifier, for: indexPath) as! NewTaskTableViewCell

        if indexPath.row == 0 {
            cell.configure(with: "Ex: \(boredTask)", identifier: Forms.titleTask)
        } else {
            cell.configure(with: "Description", identifier: Forms.descriptionTask)
        }

        cell.delegate = self

        return cell
    }
}

extension NewTaskView: UpdateDataDelegate {
    func updateData(value: String, identifier: Forms) {
        switch identifier {
        case .titleTask:
            self.titleTask = value
        case .descriptionTask:
            self.descriptionTask = value
        }
    }
}
