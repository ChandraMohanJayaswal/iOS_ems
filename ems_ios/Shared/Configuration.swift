//
//  Configuration.swift
//  ems_ios
//
//  Created by MacMini on 04/02/2026.
//

import Foundation
enum AppConfig {
    static let baseURL: String = {
        guard let value = Bundle.main.object(
            forInfoDictionaryKey: "BASE_URL"
        ) as? String else {
            fatalError("BASE_URL not found")
        }
        return "http://" + value
    }()
}
