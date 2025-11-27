//
//  Connectfy_Bem_EstarUITestsLaunchTests.swift
//  Connectfy Bem EstarUITests
//
//  Created by Fernando Araujo Ribeiro on 27/11/25.
//

import XCTest

final class Connectfy_Bem_EstarUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
