//
//  AuthBackground.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct AppBackground: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                .foregroundStyle(.background)
                .offset(x: 180, y: -380)
                .frame(width: 200, height: 200)

            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                .foregroundStyle(.background)
                .offset(x: 180, y: 300)
                .frame(width: 150, height: 150)
            Rectangle()
                .stroke(Color.black.opacity(0.1), lineWidth: 0)
                .foregroundStyle(.background)
                .background(orange.opacity(0.6))
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 100, y: -100)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.1), lineWidth: 6)
                .foregroundStyle(.background)
                .frame(width: 80, height: 80)
                .rotationEffect(Angle(degrees: 150))
                .offset(x: -190, y: -150)
            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 2)
                .background(orange.opacity(0.5))
                .clipShape(Circle())
                .frame(width: 20, height: 20)
                .offset(x: -150, y: 250)
        }
    }
}
