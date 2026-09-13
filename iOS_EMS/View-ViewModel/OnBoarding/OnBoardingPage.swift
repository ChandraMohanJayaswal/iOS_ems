//
//  OnBoardingPage.swift
//  iOS_EMS
//
//  Created by MacMini on 21/05/2026.
//

import Foundation

enum OnBoardingPage: Int, CaseIterable, Identifiable {
    case firstPage
    case secondPage
    case thirdPage
    var id: Int {
        return self.rawValue
    }
    var title: String {
        switch self {
        case .firstPage:
            return "Welcome"
        case .secondPage:
            return "Features"
        case .thirdPage:
            return "Employee Management System"
        }
    }
    var description: String {
        switch self {
        case .firstPage:
            return "Manage your team"
        case .secondPage:
            return "Analytics, Tracking, Management"
        case .thirdPage:
            return "Manage. Engage. Grow"
        }
    }
}
