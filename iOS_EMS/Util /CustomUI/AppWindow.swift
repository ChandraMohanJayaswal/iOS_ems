//
//  AppWindow.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct AppWindow: View {
    let label: String
    var image: String = "SplashLogo"
    var fillsFrame: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.78, green: 0.80, blue: 0.90))
                .offset(x: 0, y: 7)

            RoundedRectangle(cornerRadius: 24)
                .fill(Color(red: 0.94, green: 0.95, blue: 1.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            Color(red: 0.08, green: 0.10, blue: 0.17),
                            lineWidth: 2.5
                        )
                }
            VStack {
                Image(image)
                    .resizable()
                    .modifier(ImageFit(fillsFrame: fillsFrame))
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .clipped()
                Spacer()
                HStack(spacing: 6) {
                    TrafficDot(color: Color(red: 0.95, green: 0.35, blue: 0.45))
                    TrafficDot(color: Color(red: 1.0, green: 0.75, blue: 0.15))
                    TrafficDot(color: Color(red: 0.25, green: 0.30, blue: 0.75))
                }
            }
            .padding(12)
            Text(label)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .tracking(0.5)
                .foregroundStyle(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.yellow)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(.black, lineWidth: 2)
                }
                .offset(x: 24, y: -11)
        }
    }
}

private struct ImageFit: ViewModifier {
    let fillsFrame: Bool

    func body(content: Content) -> some View {
        if fillsFrame {
            content.aspectRatio(contentMode: .fill)
        } else {
            content.aspectRatio(contentMode: .fit)
        }
    }
}

private struct TrafficDot: View {
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 8, height: 8)
            .overlay {
                Circle()
                    .stroke(.black.opacity(0.35), lineWidth: 0.8)
            }
    }
}
