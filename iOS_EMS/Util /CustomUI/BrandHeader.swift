//
//  BrandHeader.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct BrandHeader: View {
    var body: some View {
        VStack {
            Text("EMS")
                .font(.poppins(.bold, size: 34))
                .foregroundStyle(blue)
            Text("Powered By Chronelab Technologies")
                .font(.inter(.bold, size: 12))
                .foregroundStyle(.gray)
        }
    }
}
