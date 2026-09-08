//
//  Fonts.swift
//  iOS_EMS
//
//  Created by MacMini on 08/09/2026.
//

import SwiftUI

enum PoppinsWeight: String {
    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    case semibold = "Poppins-SemiBold"
    case bold = "Poppins-Bold"
}

enum InterWeight: String {
    case regular = "Inter-Regular"
    case medium = "Inter-Medium"
    case semibold = "Inter-SemiBold"
    case bold = "Inter-Bold"
}

extension Font {
    static func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }

    static func inter(_ weight: InterWeight = .regular, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}