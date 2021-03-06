//
//  TaskTableViewCell.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 17/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static let reuseIdentifier = "cell"

    var label: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.textColor = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var button: UIButton = {
        let icon =  UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))

        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var checkView: UIView = {
        let view = UIView()
        view.backgroundColor = .none

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var status: Task = Task(activity: "", description: "", check: false)
    var indexPath: IndexPath = IndexPath()
    weak var delegate: ManageTaskDelegate?
    var isEditable = true

    override func prepareForReuse() {
        label.text = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        self.addSubview(label)
        self.addSubview(button)
        self.addSubview(checkView)

        self.selectionStyle = .none

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),

            label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 24),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            checkView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65),
            checkView.heightAnchor.constraint(equalToConstant: 2),
            checkView.leftAnchor.constraint(equalTo: label.leftAnchor)
        ])

        button.addTarget(self, action: #selector(checkButtonWasTapped), for: .touchUpInside)
    }

    @objc private func checkButtonWasTapped() {
        if self.isEditable {
            status.check = !status.check
            setupMarkLayout()
            self.delegate?.manageTask(indexPath: self.indexPath, task: self.status)
        }
    }

    private func setupMarkLayout() {
        let iconName = status.check ? "checkmark.circle.fill" : "circle"
        let icon = UIImage(systemName: iconName, withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        button.setImage(icon, for: .normal)

        label.textColor = status.check ? .systemGray : .none

        if status.check {
            UIView.animate(withDuration: 0.5, animations: {
                self.checkView.backgroundColor = .systemGray
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.checkView.backgroundColor = .none
            })
        }
    }

    func configure(with task: Task, indexPath: IndexPath, isEditable: Bool = true) {
        self.label.text = task.activity
        self.status = task
        self.indexPath = indexPath
        self.isEditable = isEditable

        setupMarkLayout()
    }
}
