//
//  NoveTaskView.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 22/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class NoneTaskView: UIView {

    var icon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logoGray")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var title: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No tasks here =("
        label.textColor = .systemGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(icon)
        self.addSubview(title)

        NSLayoutConstraint.activate([
          icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),

          title.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 24),
          title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
      }
}
