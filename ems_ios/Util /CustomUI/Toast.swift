//
//  Toast.swift
//  ems_ios
//
//  Created by MacMini on 06/09/2026.
//

import SwiftUI
struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let icon: String
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    HStack {
                        Image(systemName: icon)
                            .foregroundStyle(.green)
                        Text(message)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                    }
                    .background(Color.white)
                    .glassEffect()
                    .foregroundStyle(.primary)
                    .clipShape(Capsule())
                    Spacer()
                }
                .padding(.top, 20)
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: isPresented)
        .onChange(of: isPresented) {
            if isPresented {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isPresented = false
                }
            }
        }
    }
}
extension View {
    func toast(
        isPresented: Binding<Bool>,
        message: String,
        icon: String
    ) -> some View {
        modifier(
            ToastModifier(
                isPresented: isPresented,
                message: message,
                icon: icon
            )
        )
    }
}
