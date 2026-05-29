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
        app.launchArguments.append("skipSplash")
        app.launch()
    }
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    func testViewSplash() {
        XCTAssertTrue(app.staticTexts["By Chronelabs Technologies"].exists)
    }
    func testLogin() {
        let emailField = app.textFields["email"]
        let passwordField = app.secureTextFields["passwordField"]

        emailField.tap()
        emailField.typeText("test@mail.com")

        passwordField.tap()
        passwordField.typeText("123456")

        app.buttons["toggleHidePassword"].tap()
        app.buttons["loginButton"].tap()
    }

    func testTabBar() {
        app.tabBars.buttons["tab_home"].tap()
        XCTAssertTrue(app.staticTexts["Home"].exists)
        app.tabBars.buttons["tab_public_holidays"].tap()
        XCTAssertTrue(app.staticTexts["Public Holidays"].exists)
        app.tabBars.buttons["tab_leave_requests"].tap()
        XCTAssertTrue(app.staticTexts["Leave Requests"].exists)
        app.tabBars.buttons["tab_personal_leave"].tap()
        XCTAssertTrue(app.staticTexts["Personal Leaves"].exists)
    }
    func testSideMenu() {
        app.buttons["sidemenuButton"].tap()
        XCTAssertTrue(app.staticTexts["About Us"].exists)
        XCTAssertTrue(app.staticTexts["Contact Us"].exists)
        XCTAssertTrue(app.staticTexts["Sign Out"].exists)
    }
    func testSignOut() {
        app.buttons["sidemenuButton"].tap()
        app.buttons["signOutButton"].tap()
    }
}
