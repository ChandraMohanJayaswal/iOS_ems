//
//  ViewUserProfile.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI

struct ViewUserProfile: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelUserProfile()
    @State private var isPresented:Bool = false
    var body: some View{
        NavigationStack{
            Form{
                HStack{
                    Text("Role: ")
                    Spacer()
                    Text("\(viewModel.role)")
                }
                HStack{
                    Text("Name:")
                    Spacer()
                    Text("\(viewModel.firstName) \(viewModel.lastName)")
                }
                HStack{
                    Text("Gender:")
                    Spacer()
                    Text("\(viewModel.gender.rawValue)")
                }
                
                HStack{
                    Text("Date of Birth:")
                    Spacer()
                    Text(viewModel.dob, format:.dateTime.day().month().year())
                }
                
                HStack{
                    Text("Mobile No:")
                    Spacer()
                    Text("\(viewModel.mobileNumber)")
                }
                
                HStack{
                    Text("Email Address:")
                    Spacer()
                    Text("\(viewModel.emailAddress)")
                }
                
            }
            Button{
                    isPresented.toggle()
                }label:{
                    Text("Edit Info")
                    Image(systemName: "pencil")
                        .frame(width:30, height:30)
                }
            .sheet(isPresented:$isPresented){
                VStack{
                    Form{
                        Section{
                            TextField("First Name", text:$viewModel.firstName)
                            TextField("Last Name", text:$viewModel.lastName)
                            Picker("Gender", selection:$viewModel.gender){
                                ForEach(Gender.allCases){ gender in
                                    Text("\(gender.rawValue)").tag(gender)
                                }
                            }.pickerStyle(.segmented)
                            DatePicker("Date of birth", selection:$viewModel.dob, displayedComponents: [.date])
                            TextField("Mobile Number", text:$viewModel.mobileNumber)
                            TextField("Email Address", text:$viewModel.emailAddress)
                                .textInputAutocapitalization(.never)
                        }
                    }
                    Button{
                        //send data to server
                        isPresented = false
                    }label:{
                        HStack{
                            Text("Save")
                            saveIcon()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30, height:30)
                        }
                    }
                    
                }
            }
                .navigationTitle("Profile Details")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement:.topBarLeading){
                        Button{
                            withAnimation(.easeInOut){
                                coordinator.navigate(to: .tabbar)
                            }
                        } label:{
                            Image(systemName:"chevron.left")
                        }
                    }
                }
        }
    }
}

#Preview{
    ViewUserProfile()
}
struct saveIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.20833*width, y: 0.875*height))
        path.addCurve(to: CGPoint(x: 0.1495*width, y: 0.85054*height), control1: CGPoint(x: 0.18542*width, y: 0.875*height), control2: CGPoint(x: 0.16581*width, y: 0.86685*height))
        path.addCurve(to: CGPoint(x: 0.125*width, y: 0.79167*height), control1: CGPoint(x: 0.13319*width, y: 0.83424*height), control2: CGPoint(x: 0.12503*width, y: 0.81461*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: 0.20833*height))
        path.addCurve(to: CGPoint(x: 0.1495*width, y: 0.1495*height), control1: CGPoint(x: 0.125*width, y: 0.18542*height), control2: CGPoint(x: 0.13317*width, y: 0.16581*height))
        path.addCurve(to: CGPoint(x: 0.20833*width, y: 0.125*height), control1: CGPoint(x: 0.16583*width, y: 0.13319*height), control2: CGPoint(x: 0.18544*width, y: 0.12503*height))
        path.addLine(to: CGPoint(x: 0.67396*width, y: 0.125*height))
        path.addCurve(to: CGPoint(x: 0.70575*width, y: 0.13125*height), control1: CGPoint(x: 0.68507*width, y: 0.125*height), control2: CGPoint(x: 0.69567*width, y: 0.12708*height))
        path.addCurve(to: CGPoint(x: 0.73229*width, y: 0.14896*height), control1: CGPoint(x: 0.71583*width, y: 0.13542*height), control2: CGPoint(x: 0.72468*width, y: 0.14132*height))
        path.addLine(to: CGPoint(x: 0.85104*width, y: 0.26771*height))
        path.addCurve(to: CGPoint(x: 0.86875*width, y: 0.29429*height), control1: CGPoint(x: 0.85868*width, y: 0.27535*height), control2: CGPoint(x: 0.86458*width, y: 0.28421*height))
        path.addCurve(to: CGPoint(x: 0.875*width, y: 0.32604*height), control1: CGPoint(x: 0.87292*width, y: 0.30438*height), control2: CGPoint(x: 0.875*width, y: 0.31496*height))
        path.addLine(to: CGPoint(x: 0.875*width, y: 0.79167*height))
        path.addCurve(to: CGPoint(x: 0.85054*width, y: 0.85054*height), control1: CGPoint(x: 0.875*width, y: 0.81458*height), control2: CGPoint(x: 0.86685*width, y: 0.83421*height))
        path.addCurve(to: CGPoint(x: 0.79167*width, y: 0.875*height), control1: CGPoint(x: 0.83424*width, y: 0.86688*height), control2: CGPoint(x: 0.81461*width, y: 0.87503*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.875*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.79167*width, y: 0.32708*height))
        path.addLine(to: CGPoint(x: 0.67292*width, y: 0.20833*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.20833*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.79167*height))
        path.addLine(to: CGPoint(x: 0.79167*width, y: 0.79167*height))
        path.addLine(to: CGPoint(x: 0.79167*width, y: 0.32708*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5*width, y: 0.75*height))
        path.addCurve(to: CGPoint(x: 0.58854*width, y: 0.71354*height), control1: CGPoint(x: 0.53472*width, y: 0.75*height), control2: CGPoint(x: 0.56424*width, y: 0.73785*height))
        path.addCurve(to: CGPoint(x: 0.625*width, y: 0.625*height), control1: CGPoint(x: 0.61285*width, y: 0.68924*height), control2: CGPoint(x: 0.625*width, y: 0.65972*height))
        path.addCurve(to: CGPoint(x: 0.58854*width, y: 0.53646*height), control1: CGPoint(x: 0.625*width, y: 0.59028*height), control2: CGPoint(x: 0.61285*width, y: 0.56076*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.5*height), control1: CGPoint(x: 0.56424*width, y: 0.51215*height), control2: CGPoint(x: 0.53472*width, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.41146*width, y: 0.53646*height), control1: CGPoint(x: 0.46528*width, y: 0.5*height), control2: CGPoint(x: 0.43576*width, y: 0.51215*height))
        path.addCurve(to: CGPoint(x: 0.375*width, y: 0.625*height), control1: CGPoint(x: 0.38715*width, y: 0.56076*height), control2: CGPoint(x: 0.375*width, y: 0.59028*height))
        path.addCurve(to: CGPoint(x: 0.41146*width, y: 0.71354*height), control1: CGPoint(x: 0.375*width, y: 0.65972*height), control2: CGPoint(x: 0.38715*width, y: 0.68924*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.75*height), control1: CGPoint(x: 0.43576*width, y: 0.73785*height), control2: CGPoint(x: 0.46528*width, y: 0.75*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.29167*width, y: 0.41667*height))
        path.addLine(to: CGPoint(x: 0.58333*width, y: 0.41667*height))
        path.addCurve(to: CGPoint(x: 0.61304*width, y: 0.40467*height), control1: CGPoint(x: 0.59514*width, y: 0.41667*height), control2: CGPoint(x: 0.60504*width, y: 0.41267*height))
        path.addCurve(to: CGPoint(x: 0.625*width, y: 0.375*height), control1: CGPoint(x: 0.62104*width, y: 0.39667*height), control2: CGPoint(x: 0.62503*width, y: 0.38678*height))
        path.addLine(to: CGPoint(x: 0.625*width, y: 0.29167*height))
        path.addCurve(to: CGPoint(x: 0.613*width, y: 0.262*height), control1: CGPoint(x: 0.625*width, y: 0.27986*height), control2: CGPoint(x: 0.621*width, y: 0.26997*height))
        path.addCurve(to: CGPoint(x: 0.58333*width, y: 0.25*height), control1: CGPoint(x: 0.605*width, y: 0.25403*height), control2: CGPoint(x: 0.59511*width, y: 0.25003*height))
        path.addLine(to: CGPoint(x: 0.29167*width, y: 0.25*height))
        path.addCurve(to: CGPoint(x: 0.262*width, y: 0.262*height), control1: CGPoint(x: 0.27986*width, y: 0.25*height), control2: CGPoint(x: 0.26997*width, y: 0.254*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.29167*height), control1: CGPoint(x: 0.25403*width, y: 0.27*height), control2: CGPoint(x: 0.25003*width, y: 0.27989*height))
        path.addLine(to: CGPoint(x: 0.25*width, y: 0.375*height))
        path.addCurve(to: CGPoint(x: 0.262*width, y: 0.40471*height), control1: CGPoint(x: 0.25*width, y: 0.38681*height), control2: CGPoint(x: 0.254*width, y: 0.39671*height))
        path.addCurve(to: CGPoint(x: 0.29167*width, y: 0.41667*height), control1: CGPoint(x: 0.27*width, y: 0.41271*height), control2: CGPoint(x: 0.27989*width, y: 0.41669*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.20833*width, y: 0.32708*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.79167*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.20833*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.32708*height))
        path.closeSubpath()
        return path
    }
}
