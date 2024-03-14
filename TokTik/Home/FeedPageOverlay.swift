//
//  FeedPageOverlay.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct FeedPageOverlay: View {
    let feedItem: FeedItem
    @State var isFollowing = false

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(feedItem.user.name)
                        .font(.headline)
                    // Verified
                }
                Text(feedItem.description)
                    .lineLimit(2)
                Label("origineel geluid - \(feedItem.user.name)", systemImage: "music.note")
            }

            Spacer()

            VStack(spacing: 20) {
                ProfileButton(isFollowing: $isFollowing) {
                    print("Follow")
                }
                
                Button("Like") {
                    print("Like")
                }.buttonStyle(NumberIconButtonStyle(icon: "heart.fill", number: 44_300))
                Button("Comments") {
                    print("Comments")
                }.buttonStyle(NumberIconButtonStyle(icon: "ellipsis.bubble.fill", number: 339))
                Button("Bookmark") {
                    print("Bookmark")
                }.buttonStyle(NumberIconButtonStyle(icon: "bookmark.fill", number: 3918))
                Button("Reply") {
                    print("Reply")
                }.buttonStyle(NumberIconButtonStyle(icon: "arrowshape.turn.up.forward.fill", number: 9219))
            }
        }
    }
}

private struct NumberIconButtonStyle: ButtonStyle {
    let icon: String
    let number: Int
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
            Text(number, format: .number)
                .font(.headline)
        }.opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

#Preview {
    FeedPageOverlay(feedItem: .example)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.gray)
        .foregroundColor(.white)
}
