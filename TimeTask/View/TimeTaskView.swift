//
//  TimeTaskView.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 20/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class TimeTaskView: UIView {

    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var manageButton: UIButton = {
        let button = UIButton()
        button.setTitle(self.statuButton.name, for: .normal)
        button.backgroundColor = self.statuButton.color
        button.layer.cornerRadius = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var shadowManageButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 44
        view.backgroundColor = .none
        view.layer.borderWidth = 2
        view.layer.borderColor = self.statuButton.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var shadowCancelButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 44
        view.backgroundColor = .none
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    var title: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()

    var descriptionTask: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        return label
    }()

    var timerView: TimerView = {
        let view = TimerView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    let dataArray = [Array(0...23), Array(0...59)]
    let names = ["hour", "min", "sec"]
    var statuButton: StatusTimer = .start
    var timeSelected: [Int] = [0, 0, 0]
    weak var delegate: TimeDelegate?

    var seconds: Int = Int() {
        didSet {
            self.timerView.timeLabel.text = self.timeString(time: TimeInterval(self.seconds))

            if seconds == 0 {
                self.statuButton = .start
                self.configureManageButton()

                self.timerView.isHidden = true
                self.pickerView.isHidden = false
                self.delegate?.cancel()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        pickerView.delegate = self
        pickerView.dataSource = self

        configure()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.addSubview(pickerView)
        self.addSubview(shadowCancelButton)
        self.addSubview(cancelButton)
        self.addSubview(shadowManageButton)
        self.addSubview(manageButton)
        self.addSubview(title)
        self.addSubview(descriptionTask)
        self.addSubview(timerView)
    }

    private func configureLayout() {

        self.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 112),
            pickerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            pickerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            timerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 112),
            timerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            timerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            timerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 300),

            shadowCancelButton.topAnchor.constraint(equalTo: self.centerYAnchor),
            shadowCancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            shadowCancelButton.widthAnchor.constraint(equalToConstant: 88),
            shadowCancelButton.heightAnchor.constraint(equalToConstant: 88),

            cancelButton.centerXAnchor.constraint(equalTo: shadowCancelButton.centerXAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: shadowCancelButton.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 80),
            cancelButton.heightAnchor.constraint(equalToConstant: 80),

            shadowManageButton.topAnchor.constraint(equalTo: self.centerYAnchor),
            shadowManageButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            shadowManageButton.widthAnchor.constraint(equalToConstant: 88),
            shadowManageButton.heightAnchor.constraint(equalToConstant: 88),

            manageButton.centerXAnchor.constraint(equalTo: shadowManageButton.centerXAnchor),
            manageButton.centerYAnchor.constraint(equalTo: shadowManageButton.centerYAnchor),
            manageButton.widthAnchor.constraint(equalToConstant: 80),
            manageButton.heightAnchor.constraint(equalToConstant: 80),

            title.topAnchor.constraint(equalTo: manageButton.bottomAnchor, constant: 24),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            descriptionTask.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            descriptionTask.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        timerView.isHidden = true
        pickerView.isHidden = false

        cancelButton.addTarget(self, action: #selector(cancelButtonDown), for: .touchDown)
        cancelButton.addTarget(self, action: #selector(cancelButtonUp), for: .touchUpInside)

        manageButton.addTarget(self, action: #selector(manageButtonDown), for: .touchDown)
        manageButton.addTarget(self, action: #selector(manageButtonUp), for: .touchUpInside)
    }

    private func configureManageButton() {
        self.manageButton.setTitle(self.statuButton.name, for: .normal)
        self.manageButton.backgroundColor = self.statuButton.color
        self.shadowManageButton.layer.borderColor = self.statuButton.color.cgColor
    }

    private func nextStep() {
        switch self.statuButton {
        case .start:
            let timeInseconds = self.timeSelected[0] * 3600 + self.timeSelected[1] * 60 + self.timeSelected[2]
            if timeInseconds != 0 {
                self.delegate?.start(with: timeInseconds)
                self.statuButton = .pause

                self.pickerView.isHidden = true
                self.timerView.isHidden = false
                self.setAnimation()
            }
        case .pause:
            self.timerView.pause()
            self.statuButton = .resume
            self.delegate?.pause()
        case .resume:
            self.delegate?.resume()
            self.statuButton = .pause
            self.timerView.resume()
        }
    }

    private func timeString(time: TimeInterval) -> String {
        let seconds = Int(time) % 60
        let minutes = Int(time)/60 % 60
        let hours = Int(time)/3600 % 3600

        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }

    func setAnimation() {
        timerView.setAnimation(with: animatingCircle(fromValue: 0, toValue: 1, duration: TimeInterval(self.seconds)))
    }

    func animatingCircle (fromValue: Float, toValue: Float, duration: CFTimeInterval) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = fromValue
        basicAnimation.toValue = toValue
        basicAnimation.duration = duration
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        return basicAnimation
    }

    func configureLabels(with text: String, with description: String) {
        self.title.text = text
        self.descriptionTask.text = description
    }

    @objc func cancelButtonDown() {
        cancelButton.backgroundColor = .gray
        shadowCancelButton.layer.borderColor = UIColor.gray.cgColor
    }

    @objc func cancelButtonUp() {
        cancelButton.backgroundColor = .systemGray
        shadowCancelButton.layer.borderColor = UIColor.systemGray.cgColor

        self.statuButton = .start
        configureManageButton()

        self.pickerView.isHidden = false
        self.timerView.isHidden = true

        timerView.setAnimation(with: animatingCircle(fromValue: 0, toValue: 1, duration: 0))
        delegate?.cancel()
    }

    @objc func manageButtonDown() {
        let color = self.statuButton.tappedColor
        manageButton.backgroundColor = color
        shadowManageButton.layer.borderColor = color.cgColor
    }

    @objc func manageButtonUp() {
        nextStep()
        configureManageButton()
    }
}

extension TimeTaskView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
        case 0:
            return dataArray[0].count
        case 1, 3, 5:
            return 1
        case 2, 4:
            return dataArray[1].count
        default:
            return 0
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 6
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0, 2, 4:
            if component == 0 {
                return "\(dataArray[0][row])"
            } else {
                return "\(dataArray[1][row])"
            }
        case 1:
            return names[0]
        case 3:
            return names[1]
        case 5:
            return names[2]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 1, 3, 5:
            return 60
        default:
            return 40
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.timeSelected[0] = dataArray[0][row]
        case 2:
            self.timeSelected[1] = dataArray[1][row]
        case 4:
            self.timeSelected[2] = dataArray[1][row]
        default:
            print("None")
        }
    }
}
