//
//  ViewModelSplash.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import Combine
class ViewModelSplash: ObservableObject {
    var shouldSkipSplash: Bool {
        ProcessInfo.processInfo.arguments.contains("skipSplash")
    }
}
