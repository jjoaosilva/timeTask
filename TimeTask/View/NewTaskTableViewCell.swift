//
//  NewTaskTableViewCell.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 19/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class NewTaskTableViewCell: UITableViewCell {
    static let reuseIdentifier = "newTaskcell"

    lazy var titleTextField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
        textfield.placeholder = "Ex: title"
        textfield.backgroundColor = UIColor.systemBackground
        textfield.clearButtonMode = .always
        return textfield
    }()

    weak var delegate: UpdateDataDelegate?
    var identifier: Forms?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        self.addSubview(titleTextField)

        titleTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            titleTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        ])

        titleTextField.addTarget(self, action: #selector(updateTextField), for: .editingChanged)
    }

    func configure(with placeholder: String, identifier: Forms) {
        titleTextField.placeholder = placeholder
        self.identifier = identifier
    }

    @objc func updateTextField(textField: UITextField) {
        if let text = textField.text, let identifier = self.identifier {
            self.delegate?.updateData(value: text, identifier: identifier)
        }
    }
}
