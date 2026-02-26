//
//  ems_iosUITests.swift
//  ems_iosUITests
//
//  Created by MacMini on 25/12/2025.
//

import XCTest

final class ems_iosUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    override func setUpWithError()throws {
        continueAfterFailure = false
    }
    func testViewSplash() {
        XCTAssertTrue(app.staticTexts["By Chronelabs Technologies"].exists)
    }
    func testLogin() {
        XCTAssertTrue(app.staticTexts["EMS Login"].waitForExistence(timeout: 5))
        let emailField = app.textFields["email"]
        emailField.tap()
        emailField.typeText("sa@yopmail.com")
        app.buttons["toggleHidePassword"].tap()
        let passwordField = app.textFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("password")
        app.buttons["loginButton"].tap()
        XCTAssertTrue(app.staticTexts["Home"].waitForExistence(timeout: 5))
    }
    
    func testHometab() {
        app.launchArguments.append("skipSplash")
    }
}
