//
//  Months.swift
//  iOS_EMS
//
//  Created by MacMini on 08/09/2026.
//


import Combine
import Foundation

enum Months: Int, CaseIterable, Identifiable {
    case fullYear = 0
    case january = 1
    case february = 2
    case march = 3
    case april = 4
    case may = 5
    case june = 6
    case july = 7
    case august = 8
    case september = 9
    case october = 10
    case november = 11
    case december = 12

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .fullYear: return "Full Year"
        case .january: return "January"
        case .february: return "February"
        case .march: return "March"
        case .april: return "April"
        case .may: return "May"
        case .june: return "June"
        case .july: return "July"
        case .august: return "August"
        case .september: return "September"
        case .october: return "October"
        case .november: return "November"
        case .december: return "December"
        }
    }

    var month: Int? {
        self == .fullYear ? nil : rawValue
    }
}