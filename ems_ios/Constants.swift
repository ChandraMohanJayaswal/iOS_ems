// //  Constants.swift //  ems_ios // //  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI
let COLOR_BLUE = Color(red: 0/255, green: 113/255, blue: 188/255)
let COLOR_GRAY = Color(red: 0.302, green: 0.302, blue: 0.302)
let COLOR_BLACK = Color.black
let COLOR_GREEN = Color(red: 0, green: 128/255, blue: 2/255)
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
