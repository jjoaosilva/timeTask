//
//  TimerView.swift
//  TimeTask
//
//  Created by José João Silva Nunes Alves on 20/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import UIKit

class TimerView: UIView {

    lazy var circle: CAShapeLayer = {
        var circle = CAShapeLayer()
        circle.strokeColor = UIColor.systemYellow.cgColor
        circle.strokeEnd = 1
        circle.lineWidth = 10
        circle.fillColor = UIColor.clear.cgColor

        circle.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        return circle
    }()

    lazy var shadowCircle: CAShapeLayer = {
        var circle = CAShapeLayer()
        circle.strokeColor = UIColor.systemGray.cgColor
        circle.strokeEnd = 1
        circle.lineWidth = 10
        circle.fillColor = UIColor.clear.cgColor

        circle.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        return circle
    }()

    var timeLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 56, weight: .ultraLight)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00:00"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pause() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }

    func resume() {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCircleTime()
        setupTimeLabel()
    }

    func setAnimation(with animation: CABasicAnimation) {
        self.circle.add(animation, forKey: "StrokeEnd")
    }

    private func setupCircleTime() {
        let positionX = self.frame.width/2
        let positionY = self.frame.height/2

        let path = UIBezierPath(arcCenter: .zero, radius: positionY, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        self.circle.path = path.cgPath
        self.circle.position  = CGPoint(x: positionX, y: positionY)

        self.shadowCircle.path = path.cgPath
        self.shadowCircle.position  = CGPoint(x: positionX, y: positionY)

        self.layer.addSublayer(shadowCircle)
        self.layer.addSublayer(circle)
    }

    private func setupTimeLabel() {
        self.addSubview(timeLabel)

        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

//extension CALayer {
//    func pauseAnimation() {
//        if isPaused() == false {
//            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
//            speed = 0.0
//            timeOffset = pausedTime
//        }
//    }
//
//    func resumeAnimation() {
//        if isPaused() {
//            let pausedTime = timeOffset
//            speed = 1.0
//            timeOffset = 0.0
//            beginTime = 0.0
//            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//            beginTime = timeSincePause
//        }
//    }
//
//    func isPaused() -> Bool {
//        return speed == 0
//    }
//}
