//
//  OnboardingView.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-11.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "button", autoplay: false)
    @State var showModal = false
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color("Shadow").ignoresSafeArea()
                .opacity(showModal ? 0.4 : 0)
            
            content
                .offset(y: showModal ? -50 : 0)
            
            if showModal {
                SignInView(show: $showModal)
                    .opacity(showModal ? 1 : 0)
                    .offset(y: showModal ? 0 : 300)
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                showModal.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.black)
                                .background(.white)
                                .mask(Circle())
                                .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .offset(y: showModal ? 0 : 200)
                    )
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .zIndex(1)
            }
            
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(.black)
                    .mask(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .offset(y: showModal ? -200 : 80)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Learn design & code")
                .font(.custom("Poppins Bold", size: 60))
                .frame(width: 260, alignment: .leading)
            
            Text("Don’t skip design. Learn design and code, by building real apps with React and Swift. Complete courses about the best tools.")
                .customFont(.body)
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            button.view()
                .frame(width: 236, height: 64)
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset(y: 10)
                )
                .overlay(
                    Label("Start the course", systemImage: "arrow.forward")
                        .offset(x: 4, y: 4)
                        .customFont(.headline)
                        .accentColor(.primary)
                )
                .onTapGesture {
                    try? button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showModal.toggle()
                        }
                    }
                }
            
            Text("Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.")
                .customFont(.footnote)
                .opacity(0.7)
        }
        .padding(40)
        .padding(.top, 40)
        .background(
            RiveViewModel(fileName: "shapes").view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .blur(radius: 30)
                .blendMode(.hardLight)
        )
        .background(
            Image("Spline")
                .blur(radius: 50)
                .offset(x: 200, y: 100)
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true))
    }
}
