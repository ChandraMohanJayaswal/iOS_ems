//
//  Constants.swift
//  iOS_EMS
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI
let warmGray =  Color(red: 104 / 255, green: 96 / 255, blue: 96 / 255)
let lightGray =  Color(red: 183 / 255, green: 185 / 255, blue: 195 / 255)

let orange = Color(red: 0xFF/255, green: 0xA5/255, blue: 0x28/255)
let blue = Color(red: 0x26/255, green: 0x2C/255, blue: 0xCF/255)
let red = Color(red: 0xFF/255, green: 0x5E/255, blue: 0x3A/255)
let neutral = Color(red: 0x0E/255, green: 0x12/255, blue: 0x36/255)

enum TABINDEX: Int {
    case HOME = 0
    case PUBLICHOLIDAYS = 1
    case LEAVEREQUESTS = 2
    case PERSONALLEAVES = 3
    case PROFILE = 4
    case SETTINGS = 5
}
enum UISTATE {
    case loading
    case idle
}
