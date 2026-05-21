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
        XCTAssertTrue(app.staticTexts["EMS Login"].exists)
    }
}
