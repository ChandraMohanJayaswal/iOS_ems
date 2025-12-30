//
//  sideMenu.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import KeychainSwift
import SwiftUI
struct ViewSideMenu: View{
    @EnvironmentObject var coordinator: RouteCoordinator
    @State private var showBackground:Bool = false
    var body: some View{
        ZStack{
            if showBackground{
                            Rectangle()
                                .opacity(0.2)
                                .ignoresSafeArea()
                                .onTapGesture{
                                    withAnimation(.easeInOut){
                                        coordinator.navigate(to:.tabbar)
                                    }
                                }
            }
            HStack{
                VStack{
                    SideMenuUserProfile()
                    Divider()
                        .background(.gray)
                    Button{
                    } label:{
                        SideMenuTabs(title:"About Us", icon:"person.2.fill")
                    }
                    Divider()
                        .background(.gray)
                    Button{
                    } label:{
                        SideMenuTabs(title:"Contact Us", icon:"paperplane")
                    }
                    Divider()
                        .background(.gray)
                    
                    Button{
                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                        coordinator.selectedTab = 0
                        KeychainSwift().clear()
                        coordinator.navigate(to: .login)
                        if let bundleID = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: bundleID)
                        }
                    } label:{
                        SideMenuTabs(title:"Sign Out", icon:"door.right.hand.open")
                    }
                    Divider()
                        .background(.gray)
                    Spacer()
                }
                .frame(width:300)
                .background(.white)
                Spacer()
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline:.now()+0.1){
                showBackground = true
            }
        }
    }
}

#Preview{
    ViewSideMenu()
}
struct SideMenuUserProfile: View{
    @EnvironmentObject var coordinator: RouteCoordinator
    var body:some View{
        HStack{
            Image(systemName:"person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width:48, height:48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius:10))
            VStack(alignment:.leading){
                Text("\(UserDefaults.standard.string(forKey: "firstName") ?? "NA") \(UserDefaults.standard.string(forKey: "lastName") ?? "NA")")
                    .font(.title2)
                    .foregroundStyle(Color.black)
                Text("\(UserDefaults.standard.string(forKey: "emailAddress") ?? "NA")")
                    .foregroundStyle(Color.gray)
                    .font(.caption)
            }
            Spacer()
        }
        .onTapGesture{
            withAnimation(.easeInOut){
                coordinator.navigate(to:.userProfile)
            }
        }
        .padding()
    }
}

struct SideMenuTabs: View{
    var title: String = ""
    var icon: String=""
    var body: some View{
        HStack{
            Image(systemName:"\(icon)")
            Text("\(title)")
            Spacer()
            Image(systemName:"chevron.right")
        }
        .padding()
    }
}
