//
//  ContentView.swift
//  SwiftUIShape
//
//  Created by Djuro Alfirevic on 4/15/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)
    
    var body: some View {
        VStack {
            Path() { path in
                path.move(to: CGPoint(x: 20, y: 20))
                path.addLine(to: CGPoint(x: 300, y: 20))
                path.addLine(to: CGPoint(x: 300, y: 200))
                path.addLine(to: CGPoint(x: 20, y: 200))
                path.closeSubpath()
            }
            .stroke(Color.green, lineWidth: 10)
            
//            Path() { path in
//                path.move(to: CGPoint(x: 20, y: 60))
//                path.addLine(to: CGPoint(x: 40, y: 60))
//                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
//                path.addLine(to: CGPoint(x: 230, y: 60))
//                path.addLine(to: CGPoint(x: 230, y: 100))
//                path.addLine(to: CGPoint(x: 20, y: 100))
//                path.closeSubpath()
//            }
//            .fill(Color.purple)
//
//            Path() { path in
//                path.move(to: CGPoint(x: 20, y: 60))
//                path.addLine(to: CGPoint(x: 40, y: 60))
//                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
//                path.addLine(to: CGPoint(x: 230, y: 60))
//                path.addLine(to: CGPoint(x: 230, y: 100))
//                path.addLine(to: CGPoint(x: 20, y: 100))
//            }
//            .fill(Color.purple)
//
//            ZStack {
//                Path() { path in
//                    path.move(to: CGPoint(x: 20, y: 60))
//                    path.addLine(to: CGPoint(x: 40, y: 60))
//                    path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
//                    path.addLine(to: CGPoint(x: 230, y: 60))
//                    path.addLine(to: CGPoint(x: 230, y: 100))
//                    path.addLine(to: CGPoint(x: 20, y: 100))
//                }
//                .fill(Color.purple)
//
//                Path() { path in
//                    path.move(to: CGPoint(x: 20, y: 60))
//                    path.addLine(to: CGPoint(x: 40, y: 60))
//                    path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
//                    path.addLine(to: CGPoint(x: 230, y: 60))
//                    path.addLine(to: CGPoint(x: 230, y: 100))
//                    path.addLine(to: CGPoint(x: 20, y: 100))
//                    path.closeSubpath()
//                }
//                .stroke(Color.black, lineWidth: 5)
//            }
//
//            Path() { path in
//                path.move(to: CGPoint(x: 200, y: 200))
//                path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 90), clockwise: true)
//            }
//            .fill(Color.green)
            
//            ZStack {
//                Path { path in
//                    path.move(to: CGPoint(x: 200, y: 200))
//                    path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 190), clockwise: true)
//                }
//                .fill(Color(.systemYellow))
//
//                Path { path in
//                    path.move(to: CGPoint(x: 200, y: 200))
//                    path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 190), endAngle: Angle(degrees: 110), clockwise: true)
//                }
//                .fill(Color(.systemTeal))
//
//                Path { path in
//                    path.move(to: CGPoint(x: 200, y: 200))
//                    path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 110), endAngle: Angle(degrees: 90), clockwise: true)
//                }
//                .fill(Color(.systemBlue))
//
//                Path { path in
//                    path.move(to: CGPoint(x: 200, y: 200))
//                    path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 360), clockwise: true)
//                }
//                .fill(Color(.systemPurple))
//                .offset(x: 20, y: 20)
//
//                Path { path in
//                    path.move(to: CGPoint(x: 200, y: 200))
//                    path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 360), clockwise: true)
//                    path.closeSubpath()
//                }
//                .stroke(Color(red: 52/255, green: 52/255, blue: 122/255), lineWidth: 10)
//                .offset(x: 20, y: 20)
//                .overlay(
//                    Text("25%")
//                        .font(.system(.largeTitle, design: .rounded))
//                        .bold()
//                        .foregroundColor(.white)
//                        .offset(x: 80, y: 80)
//                )
//            }
//
//            Path() { path in
//                path.move(to: CGPoint(x: 0, y: 0))
//                path.addQuadCurve(to: CGPoint(x: 200, y: 0), control: CGPoint(x: 100, y: -20))
//                path.addLine(to: CGPoint(x: 200, y: 40))
//                path.addLine(to: CGPoint(x: 200, y: 40))
//                path.addLine(to: CGPoint(x: 0, y: 40))
//            }
//            .fill(Color.green)
//
//            Button(action: {
//                // Action to perform
//            }) {
//                Text("Test")
//                    .font(.system(.title, design: .rounded))
//                    .bold()
//                    .foregroundColor(.white)
//                    .frame(width: 250, height: 50)
//                    .background(Dome().fill(Color.red))
//            }
//
//            ZStack {
//                Circle()
//                    .stroke(Color(.systemGray6), lineWidth: 20)
//                    .frame(width: 300, height: 300)
//
//                Circle()
//                    .trim(from: 0.0, to: 0.85)
//                    .stroke(purpleGradient, lineWidth: 20)
//                    .frame(width: 300, height: 300)
//                    .overlay(
//                        VStack {
//                            Text("85%")
//                                .font(.system(size: 80, weight: .bold, design: .rounded))
//                                .foregroundColor(Color(.systemGray))
//                            Text("Complete")
//                                .font(.system(.body, design: .rounded))
//                                .bold()
//                                .foregroundColor(Color(.systemGray))
//                        }
//                    )
//            }
            
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.4)
                    .stroke(Color(.systemBlue), lineWidth: 80)

                Circle()
                    .trim(from: 0.4, to: 0.6)
                    .stroke(Color(.systemTeal), lineWidth: 80)

                Circle()
                    .trim(from: 0.6, to: 0.75)
                    .stroke(Color(.systemPurple), lineWidth: 80)

                Circle()
                    .trim(from: 0.75, to: 1)
                    .stroke(Color(.systemYellow), lineWidth: 90)
                    .overlay(
                        Text("25%")
                            .font(.system(.title, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                            .offset(x: 120, y: -100)
                    )
            }
            .frame(width: 300, height: 300)
        }
    }
}

struct Dome: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width, y: 0), control: CGPoint(x: rect.size.width/2, y: -(rect.size.width * 0.1)))
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))

        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
