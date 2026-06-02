// //  Constants.swift //  ems_ios // //  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI
let COLOR_BLUE = Color(red: 0/255, green: 113/255, blue: 188/255)
let COLOR_GRAY = Color(red: 0.302, green: 0.302, blue: 0.302)
let COLOR_BLACK = Color.black
let COLOR_GREEN = Color(red: 0, green: 128/255, blue: 2/255)



let primaryBlue      = Color(red: 74/255, green: 78/255, blue: 242/255)
let royalBlue        = Color(red: 62/255, green: 65/255, blue: 232/255)
let deepIndigo       = Color(red: 52/255, green: 56/255, blue: 221/255)
let vividIndigo      = Color(red: 43/255, green: 47/255, blue: 209/255)
let darkBlue         = Color(red: 38/255, green: 44/255, blue: 207/255)

let pureWhite = Color.white
let glassWhiteLight = Color.white.opacity(0.08)
let glassWhite = Color.white.opacity(0.12)
let glassWhiteBold = Color.white.opacity(0.20)
let ashWhite = Color(red: 0.95, green: 0.95, blue: 0.93)

let softWhite = Color(red: 232/255, green: 234/255, blue: 255/255)
let paleLavender = Color(red: 201/255, green: 204/255, blue: 248/255)
let mutedLavender    = Color(red: 142/255, green: 146/255, blue: 201/255)

let borderBlue       = Color(red: 107/255, green: 112/255, blue: 232/255)
let borderHighlight  = Color(red: 124/255, green: 128/255, blue: 240/255)

let iconBlue         = Color(red: 106/255, green: 110/255, blue: 245/255)
let iconGlow         = Color(red: 122/255, green: 126/255, blue: 248/255)

let accentBlue       = Color(red: 93/255, green: 98/255, blue: 255/255)
let brightAccent     = Color(red: 79/255, green: 84/255, blue: 250/255)

let shadowBlue       = Color(red: 31/255, green: 35/255, blue: 153/255)
let glowBlue         = Color(red: 42/255, green: 46/255, blue: 216/255)

let successGreen     = Color(red: 34/255, green: 197/255, blue: 94/255)
let warningAmber     = Color(red: 245/255, green: 158/255, blue: 11/255)
let errorRed         = Color(red: 239/255, green: 68/255, blue: 68/255)

enum TABINDEX: Int{
    case HOME = 0
    case PUBLICHOLIDAYS = 1
    case LEAVEREQUESTS = 2
    case PERSONALLEAVES = 3
}
enum UISTATE{
    case loading
    case idle
}
