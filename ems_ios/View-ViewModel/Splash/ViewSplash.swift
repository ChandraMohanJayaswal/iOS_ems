//
//  ViewSplash.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//
import SwiftUI
struct ViewSplash:View{
    @EnvironmentObject var coordinator: RouteCoordinator
    @State private var angle: CGFloat = 0
    @State private var scaledValue: CGFloat=1
    var body: some View{
        Text("EMS")
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .fontWeight(.heavy)
        Text("By Chronelabs Technologies")
            .foregroundStyle(.gray)
            ZStack(alignment: .topTrailing){
                Image(systemName:"person.2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scaledValue)
                    .animation(.easeInOut(duration:2).repeatForever(autoreverses: true), value:scaledValue)
                    .frame(width:150, height:100)
                    .foregroundStyle(.blue)
                    .padding(40)
                GearShape()
                    .foregroundStyle(.blue)
                    .frame(width:60, height:60)
                    .rotationEffect(.degrees(angle))
                    .animation(.easeInOut(duration:2).repeatForever(autoreverses: true), value:angle)
                    .onAppear{
                        angle=360
                        scaledValue=1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if UserDefaults.standard.bool(forKey:"isUserLoggedIn"){
                                coordinator.navigate(to: .tabbar)
                            }
                            else {
                                coordinator.navigate(to: .login)
                            }
                        }
                    }
            }
    }
}
#Preview{
    ViewSplash()
}
    
struct GearShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.58824*width, y: 0.07974*height))
        path.addCurve(to: CGPoint(x: 0.5281*width, y: 0.01961*height), control1: CGPoint(x: 0.58824*width, y: 0.04652*height), control2: CGPoint(x: 0.56132*width, y: 0.01961*height))
        path.addLine(to: CGPoint(x: 0.45887*width, y: 0.01961*height))
        path.addCurve(to: CGPoint(x: 0.39869*width, y: 0.07974*height), control1: CGPoint(x: 0.42561*width, y: 0.01961*height), control2: CGPoint(x: 0.39869*width, y: 0.04652*height))
        path.addCurve(to: CGPoint(x: 0.35439*width, y: 0.14068*height), control1: CGPoint(x: 0.39869*width, y: 0.10713*height), control2: CGPoint(x: 0.37993*width, y: 0.13063*height))
        path.addCurve(to: CGPoint(x: 0.3424*width, y: 0.1457*height), control1: CGPoint(x: 0.35034*width, y: 0.14232*height), control2: CGPoint(x: 0.34635*width, y: 0.144*height))
        path.addCurve(to: CGPoint(x: 0.26791*width, y: 0.1339*height), control1: CGPoint(x: 0.31724*width, y: 0.1566*height), control2: CGPoint(x: 0.28734*width, y: 0.15328*height))
        path.addCurve(to: CGPoint(x: 0.2254*width, y: 0.11632*height), control1: CGPoint(x: 0.25663*width, y: 0.12265*height), control2: CGPoint(x: 0.24134*width, y: 0.11632*height))
        path.addCurve(to: CGPoint(x: 0.1829*width, y: 0.1339*height), control1: CGPoint(x: 0.20947*width, y: 0.11632*height), control2: CGPoint(x: 0.19418*width, y: 0.12265*height))
        path.addLine(to: CGPoint(x: 0.1339*width, y: 0.1829*height))
        path.addCurve(to: CGPoint(x: 0.11632*width, y: 0.2254*height), control1: CGPoint(x: 0.12265*width, y: 0.19418*height), control2: CGPoint(x: 0.11632*width, y: 0.20947*height))
        path.addCurve(to: CGPoint(x: 0.1339*width, y: 0.26791*height), control1: CGPoint(x: 0.11632*width, y: 0.24134*height), control2: CGPoint(x: 0.12265*width, y: 0.25663*height))
        path.addCurve(to: CGPoint(x: 0.14565*width, y: 0.3424*height), control1: CGPoint(x: 0.15333*width, y: 0.28734*height), control2: CGPoint(x: 0.15665*width, y: 0.31719*height))
        path.addCurve(to: CGPoint(x: 0.14068*width, y: 0.35439*height), control1: CGPoint(x: 0.14393*width, y: 0.34637*height), control2: CGPoint(x: 0.14227*width, y: 0.35036*height))
        path.addCurve(to: CGPoint(x: 0.07974*width, y: 0.39869*height), control1: CGPoint(x: 0.13063*width, y: 0.37993*height), control2: CGPoint(x: 0.10713*width, y: 0.39869*height))
        path.addCurve(to: CGPoint(x: 0.01961*width, y: 0.45883*height), control1: CGPoint(x: 0.04652*width, y: 0.39869*height), control2: CGPoint(x: 0.01961*width, y: 0.42561*height))
        path.addLine(to: CGPoint(x: 0.01961*width, y: 0.5281*height))
        path.addCurve(to: CGPoint(x: 0.07974*width, y: 0.58824*height), control1: CGPoint(x: 0.01961*width, y: 0.56132*height), control2: CGPoint(x: 0.04652*width, y: 0.58824*height))
        path.addCurve(to: CGPoint(x: 0.14068*width, y: 0.63254*height), control1: CGPoint(x: 0.10713*width, y: 0.58824*height), control2: CGPoint(x: 0.13063*width, y: 0.607*height))
        path.addCurve(to: CGPoint(x: 0.14565*width, y: 0.64453*height), control1: CGPoint(x: 0.14232*width, y: 0.63658*height), control2: CGPoint(x: 0.14398*width, y: 0.64058*height))
        path.addCurve(to: CGPoint(x: 0.1339*width, y: 0.71902*height), control1: CGPoint(x: 0.1566*width, y: 0.66969*height), control2: CGPoint(x: 0.15328*width, y: 0.69959*height))
        path.addCurve(to: CGPoint(x: 0.11632*width, y: 0.76152*height), control1: CGPoint(x: 0.12265*width, y: 0.7303*height), control2: CGPoint(x: 0.11632*width, y: 0.74559*height))
        path.addCurve(to: CGPoint(x: 0.1339*width, y: 0.80403*height), control1: CGPoint(x: 0.11632*width, y: 0.77746*height), control2: CGPoint(x: 0.12265*width, y: 0.79275*height))
        path.addLine(to: CGPoint(x: 0.1829*width, y: 0.85303*height))
        path.addCurve(to: CGPoint(x: 0.2254*width, y: 0.8706*height), control1: CGPoint(x: 0.19418*width, y: 0.86428*height), control2: CGPoint(x: 0.20947*width, y: 0.8706*height))
        path.addCurve(to: CGPoint(x: 0.26791*width, y: 0.85303*height), control1: CGPoint(x: 0.24134*width, y: 0.8706*height), control2: CGPoint(x: 0.25663*width, y: 0.86428*height))
        path.addCurve(to: CGPoint(x: 0.3424*width, y: 0.84123*height), control1: CGPoint(x: 0.28734*width, y: 0.8336*height), control2: CGPoint(x: 0.31719*width, y: 0.83028*height))
        path.addCurve(to: CGPoint(x: 0.35439*width, y: 0.84625*height), control1: CGPoint(x: 0.34635*width, y: 0.84296*height), control2: CGPoint(x: 0.35034*width, y: 0.84464*height))
        path.addCurve(to: CGPoint(x: 0.39869*width, y: 0.90719*height), control1: CGPoint(x: 0.37993*width, y: 0.8563*height), control2: CGPoint(x: 0.39869*width, y: 0.8798*height))
        path.addCurve(to: CGPoint(x: 0.45883*width, y: 0.96732*height), control1: CGPoint(x: 0.39869*width, y: 0.94041*height), control2: CGPoint(x: 0.42561*width, y: 0.96732*height))
        path.addLine(to: CGPoint(x: 0.5281*width, y: 0.96732*height))
        path.addCurve(to: CGPoint(x: 0.58824*width, y: 0.90719*height), control1: CGPoint(x: 0.56132*width, y: 0.96732*height), control2: CGPoint(x: 0.58824*width, y: 0.94041*height))
        path.addCurve(to: CGPoint(x: 0.63254*width, y: 0.8462*height), control1: CGPoint(x: 0.58824*width, y: 0.8798*height), control2: CGPoint(x: 0.607*width, y: 0.8563*height))
        path.addCurve(to: CGPoint(x: 0.64453*width, y: 0.84127*height), control1: CGPoint(x: 0.63658*width, y: 0.84462*height), control2: CGPoint(x: 0.64058*width, y: 0.84298*height))
        path.addCurve(to: CGPoint(x: 0.71897*width, y: 0.85303*height), control1: CGPoint(x: 0.66969*width, y: 0.83028*height), control2: CGPoint(x: 0.69959*width, y: 0.83365*height))
        path.addCurve(to: CGPoint(x: 0.7615*width, y: 0.87063*height), control1: CGPoint(x: 0.73026*width, y: 0.8643*height), control2: CGPoint(x: 0.74555*width, y: 0.87063*height))
        path.addCurve(to: CGPoint(x: 0.80403*width, y: 0.85303*height), control1: CGPoint(x: 0.77745*width, y: 0.87063*height), control2: CGPoint(x: 0.79275*width, y: 0.8643*height))
        path.addLine(to: CGPoint(x: 0.85303*width, y: 0.80403*height))
        path.addCurve(to: CGPoint(x: 0.8706*width, y: 0.76152*height), control1: CGPoint(x: 0.86428*width, y: 0.79275*height), control2: CGPoint(x: 0.8706*width, y: 0.77746*height))
        path.addCurve(to: CGPoint(x: 0.85303*width, y: 0.71902*height), control1: CGPoint(x: 0.8706*width, y: 0.74559*height), control2: CGPoint(x: 0.86428*width, y: 0.7303*height))
        path.addCurve(to: CGPoint(x: 0.84123*width, y: 0.64453*height), control1: CGPoint(x: 0.8336*width, y: 0.69959*height), control2: CGPoint(x: 0.83028*width, y: 0.66974*height))
        path.addCurve(to: CGPoint(x: 0.84625*width, y: 0.63254*height), control1: CGPoint(x: 0.84296*width, y: 0.64058*height), control2: CGPoint(x: 0.84464*width, y: 0.63658*height))
        path.addCurve(to: CGPoint(x: 0.90719*width, y: 0.58824*height), control1: CGPoint(x: 0.8563*width, y: 0.607*height), control2: CGPoint(x: 0.8798*width, y: 0.58824*height))
        path.addCurve(to: CGPoint(x: 0.96732*width, y: 0.5281*height), control1: CGPoint(x: 0.94041*width, y: 0.58824*height), control2: CGPoint(x: 0.96732*width, y: 0.56132*height))
        path.addLine(to: CGPoint(x: 0.96732*width, y: 0.45887*height))
        path.addCurve(to: CGPoint(x: 0.90719*width, y: 0.39874*height), control1: CGPoint(x: 0.96732*width, y: 0.42565*height), control2: CGPoint(x: 0.94041*width, y: 0.39874*height))
        path.addCurve(to: CGPoint(x: 0.8462*width, y: 0.35444*height), control1: CGPoint(x: 0.8798*width, y: 0.39874*height), control2: CGPoint(x: 0.8563*width, y: 0.37997*height))
        path.addCurve(to: CGPoint(x: 0.84123*width, y: 0.34245*height), control1: CGPoint(x: 0.84461*width, y: 0.35041*height), control2: CGPoint(x: 0.84295*width, y: 0.34641*height))
        path.addCurve(to: CGPoint(x: 0.85303*width, y: 0.26795*height), control1: CGPoint(x: 0.83033*width, y: 0.31728*height), control2: CGPoint(x: 0.83365*width, y: 0.28738*height))
        path.addCurve(to: CGPoint(x: 0.8706*width, y: 0.22545*height), control1: CGPoint(x: 0.86428*width, y: 0.25667*height), control2: CGPoint(x: 0.8706*width, y: 0.24139*height))
        path.addCurve(to: CGPoint(x: 0.85303*width, y: 0.18295*height), control1: CGPoint(x: 0.8706*width, y: 0.20951*height), control2: CGPoint(x: 0.86428*width, y: 0.19423*height))
        path.addLine(to: CGPoint(x: 0.80403*width, y: 0.13395*height))
        path.addCurve(to: CGPoint(x: 0.76152*width, y: 0.11637*height), control1: CGPoint(x: 0.79275*width, y: 0.12269*height), control2: CGPoint(x: 0.77746*width, y: 0.11637*height))
        path.addCurve(to: CGPoint(x: 0.71902*width, y: 0.13395*height), control1: CGPoint(x: 0.74559*width, y: 0.11637*height), control2: CGPoint(x: 0.7303*width, y: 0.12269*height))
        path.addCurve(to: CGPoint(x: 0.64453*width, y: 0.14575*height), control1: CGPoint(x: 0.69959*width, y: 0.15338*height), control2: CGPoint(x: 0.66974*width, y: 0.15669*height))
        path.addCurve(to: CGPoint(x: 0.63254*width, y: 0.14073*height), control1: CGPoint(x: 0.64056*width, y: 0.14401*height), control2: CGPoint(x: 0.63656*width, y: 0.14233*height))
        path.addCurve(to: CGPoint(x: 0.58824*width, y: 0.07974*height), control1: CGPoint(x: 0.607*width, y: 0.13063*height), control2: CGPoint(x: 0.58824*width, y: 0.10708*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.68301*width, y: 0.49346*height))
        path.addCurve(to: CGPoint(x: 0.62749*width, y: 0.62749*height), control1: CGPoint(x: 0.68301*width, y: 0.54373*height), control2: CGPoint(x: 0.66304*width, y: 0.59195*height))
        path.addCurve(to: CGPoint(x: 0.49346*width, y: 0.68301*height), control1: CGPoint(x: 0.59195*width, y: 0.66304*height), control2: CGPoint(x: 0.54373*width, y: 0.68301*height))
        path.addCurve(to: CGPoint(x: 0.35944*width, y: 0.62749*height), control1: CGPoint(x: 0.44319*width, y: 0.68301*height), control2: CGPoint(x: 0.39498*width, y: 0.66304*height))
        path.addCurve(to: CGPoint(x: 0.30392*width, y: 0.49346*height), control1: CGPoint(x: 0.32389*width, y: 0.59195*height), control2: CGPoint(x: 0.30392*width, y: 0.54373*height))
        path.addCurve(to: CGPoint(x: 0.35944*width, y: 0.35944*height), control1: CGPoint(x: 0.30392*width, y: 0.44319*height), control2: CGPoint(x: 0.32389*width, y: 0.39498*height))
        path.addCurve(to: CGPoint(x: 0.49346*width, y: 0.30392*height), control1: CGPoint(x: 0.39498*width, y: 0.32389*height), control2: CGPoint(x: 0.44319*width, y: 0.30392*height))
        path.addCurve(to: CGPoint(x: 0.62749*width, y: 0.35944*height), control1: CGPoint(x: 0.54373*width, y: 0.30392*height), control2: CGPoint(x: 0.59195*width, y: 0.32389*height))
        path.addCurve(to: CGPoint(x: 0.68301*width, y: 0.49346*height), control1: CGPoint(x: 0.66304*width, y: 0.39498*height), control2: CGPoint(x: 0.68301*width, y: 0.44319*height))
        path.closeSubpath()
        return path
    }
}
