//
//  LoadingBar.swift
//  iOS_EMS
//
//  Created by MacMini on 08/09/2026.
//


import SwiftUI

struct LoadingBar: View {
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(.gray)

                // Moving segment
                Capsule()
                    .fill(blue)
                    .frame(width: 24)
                    .offset(
                        x: animate
                            ? geo.size.width - 24
                            : 0
                    )
            }
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true)
                ) {
                    animate = true
                }
            }
        }
        .frame(width: 190, height: 4)
    }
}