//
//  ProfileButton.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct ProfileButton: View {
    @Binding var isFollowing: Bool
    @State private var rotating = false
    let action: () -> Void

    var body: some View {
        Button(action: {
            isFollowing.toggle()
            rotating.toggle()
            action()
        }) {
            Image("mathijs")
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .clipShape(Circle())
                .overlay(alignment: .bottom) {
                    Image(systemName: "plus")
                        .font(.body.bold())
                        .foregroundColor(.white)
//                    Checkmark()
//                        .stroke(.white, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .padding(4)
                        .frame(width: 24, height: 24)
                        .background(.red)
                        .clipShape(Circle())
                        .rotationEffect(Angle(degrees: rotating ? 180 : 0))
                        .animation(Animation.linear(duration: 1), value: rotating)
                                            .transition(.opacity)
                        .offset(y: 12)
                }
                .animation(.default, value: isFollowing)
        }
        .padding(.bottom, 12)
    }
}

struct Checkmark: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}

struct Plus: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct ProfileButton_Preview: View {
    @State var isFollowing = false
    var body: some View {
//        Checkmark()
//            .stroke(.black, style: StrokeStyle(lineWidth: 10, lineCap: .round))
//            .frame(width: 100, height: 100)

        ProfileButton(isFollowing: $isFollowing) { print("Following: \(isFollowing)") }
    }
}

#Preview {
    ProfileButton_Preview()
}
