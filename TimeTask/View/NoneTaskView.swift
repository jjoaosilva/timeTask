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

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {

        self.addSubview(icon)
        NSLayoutConstraint.activate([
          icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
      }
}
