//
//  GradientProfilePicture.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 4/8/21.
//

import SwiftUI

struct GradientProfilePicture: View {
    var profilePicture: UIImage
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1),
    ]

    @State private var angle: Double = 0

    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                .mask(
                    Circle()
                        .frame(width: 70, height: 70, alignment: .center)
                        .blur(radius: 8.0)
                )
                .blur(radius: 8.0)
                .onAppear {
                    withAnimation(.linear(duration: 7)) {
                        self.angle += 350
                    }
                }
            Image(uiImage: profilePicture)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 66, height: 66, alignment: .center)
                .mask(
                    Circle()
            )
        }

    }
}

struct GradientProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                GradientProfilePicture(profilePicture: UIImage(named: "Profile")!)
                Spacer()
            }
            Spacer()
        }
        .background(Color.black)
            
    }
}
