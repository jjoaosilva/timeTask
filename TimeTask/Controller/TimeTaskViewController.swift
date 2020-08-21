//
//  TimeTaskViewController.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 20/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

// swiftlint:disable  line_length

class TimeTaskViewController: UIViewController {

    var titleTask: String = String()
    var descriptionTask: String = String()

    let inicialTime = 0
    var timer = Timer()
    var isTimerRunning = false
    var timerTaskView = TimeTaskView()

    var seconds: Int = Int() {
        didSet {
            self.timerTaskView.seconds = self.seconds
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configurateNavigation()
        seconds = self.inicialTime

        self.timerTaskView.delegate = self
        self.timerTaskView.configureLabels(with: titleTask, with: descriptionTask)
        self.view = timerTaskView

    }

    func playTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    func pauseTimer() {
        timer.invalidate()
    }

    func cancelTimer() {
        timer.invalidate()
        self.seconds = self.inicialTime
    }

    @objc func updateTimer() {
        if seconds < 1 {
            self.cancelTimer()
        } else {
            seconds -= 1
        }
    }

    private func configurateNavigation() {
        self.title = "Time Task"
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension TimeTaskViewController: TimeDelegate {
    func start(with time: Int) {
        self.seconds = time
        self.playTimer()
    }

    func pause() {
        self.pauseTimer()
    }

    func resume() {
        self.playTimer()
    }

    func cancel() {
        self.cancelTimer()
    }
}
