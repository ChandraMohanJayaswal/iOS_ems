//
//  SyncIndicator.swift
//  iOS_EMS
//
//  Created by MacMini on 08/09/2026.
//


import SwiftUI

struct SyncIndicator: View {
    @State private var rotation = 0.0

    var body: some View {
        Circle()
            .trim(from: 0.05, to: 0.75)
            .stroke(
                blue,
                style: StrokeStyle(
                    lineWidth: 2,
                    lineCap: .round
                )
            )
            .frame(width: 12, height: 12)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    .linear(duration: 0.8)
                        .repeatForever(autoreverses: false)
                ) {
                    rotation = 360
                }
            }
    }
}