//
//  TimeTaskTests.swift
//  TimeTaskTests
//
//  Created by José João Silva Nunes Alves on 13/08/20.
//  Copyright © 2020 José João Silva Nunes Alves. All rights reserved.
//

import XCTest
@testable import TimeTask

class TimeTaskTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func test_StatusTimer_getColor_pause() {
        let sut = StatusTimer.pause
        XCTAssertEqual(sut.color, UIColor.systemYellow)
    }

    func test_StatusTimer_getShadowColor_pause() {
        let sut = StatusTimer.pause
        XCTAssertEqual(sut.tappedColor, UIColor(red: 0.89, green: 0.71, blue: 0.00, alpha: 1.00))
    }

    func test_StatusTimer_getColor_start() {
        let sut = StatusTimer.start
        XCTAssertEqual(sut.color, UIColor.systemGreen)
    }

    func test_StatusTimer_getShadowColor_start() {
        let sut = StatusTimer.start
        XCTAssertEqual(sut.tappedColor, UIColor(red: 0.27, green: 0.75, blue: 0.35, alpha: 1.00))
    }

    func test_StatusTimer_getColor_resume() {
        let sut = StatusTimer.resume
        XCTAssertEqual(sut.color, UIColor.systemGreen)
    }

    func test_StatusTimer_getShadowColor_resume() {
        let sut = StatusTimer.resume
        XCTAssertEqual(sut.tappedColor, UIColor(red: 0.27, green: 0.75, blue: 0.35, alpha: 1.00))
    }

    func test_StatusTimer_getName_pause() {
        let sut = StatusTimer.pause
        XCTAssertEqual(sut.name, "Pause")
    }

    func test_StatusTimer_getName_start() {
        let sut = StatusTimer.start
        XCTAssertEqual(sut.name, "Start")
    }

    func test_StatusTimer_getName_resume() {
        let sut = StatusTimer.resume
        XCTAssertEqual(sut.name, "Resume")
    }

    func test_onboarding_data_page01() {
        let sut = Onboard.mockOnboard()

        XCTAssertEqual(sut[0].image, "page01Onboarding")
    }

    func test_onboarding_data_page02() {
        let sut = Onboard.mockOnboard()

        XCTAssertEqual(sut[1].image, "page02Onboarding")
    }

    func test_onboarding_data_page03() {
        let sut = Onboard.mockOnboard()

        XCTAssertEqual(sut[2].image, "page03Onboarding")
    }

    func test_generate_url_api() {
        let sut = BoredRequest()

        XCTAssertEqual(sut.resourceURL.absoluteString, "http://www.boredapi.com/api/activity?type=busywork")
    }
}
