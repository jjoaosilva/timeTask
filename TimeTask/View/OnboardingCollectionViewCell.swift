//
//  OnboardingCollectionViewCell.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 19/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "OnboardCell"

    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    let descriptionOnboard: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 56, bottom: 8, right: 56)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        return button
    }()

    let skipButton: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 56, bottom: 8, right: 56)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .none
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Skip", for: .normal)
        return button

    }()

    var nextButtonAction: (() -> Void)?
    var skipButtonAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemBackground
        contructView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(onBoard: Onboard, action: (() -> Void)?, skip: (() -> Void)?) {
        self.image.image = UIImage(named: onBoard.image)
        self.descriptionOnboard.text = onBoard.subtitle
        self.nextButton.setTitle(onBoard.buttonTitle, for: .normal)
        self.nextButtonAction = action
        self.skipButtonAction = skip
    }

    private func contructView() {
        self.addSubview(image)
        self.addSubview(nextButton)
        self.addSubview(skipButton)
        self.addSubview(descriptionOnboard)

        nextButton.addTarget(self, action: #selector(nextButtonWasTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonWasTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: descriptionOnboard.topAnchor, constant: -50),

            descriptionOnboard.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            descriptionOnboard.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            descriptionOnboard.topAnchor.constraint(equalTo: self.centerYAnchor),

            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor),

            skipButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }

    @objc private func nextButtonWasTapped() {
       nextButtonAction?()
    }

    @objc private func skipButtonWasTapped() {
        skipButtonAction?()
    }
}
