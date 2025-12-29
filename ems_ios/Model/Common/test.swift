//
//  test.swift
//  ems_ios
//
//  Created by MacMini on 29/12/2025.
//


import SwiftUI
struct test: View{
    var body: some View{
        Button{
            Task{
                await AuthAPI.login()
            }
        } label:{
            
            RoundedRectangle(cornerRadius:10)
        }
        .frame(width:50, height:50)
    }
}
#Preview{
    test()
}
