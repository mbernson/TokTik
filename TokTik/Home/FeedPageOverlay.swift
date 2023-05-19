//
//  FeedPageOverlay.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct FeedPageOverlay: View {
    let feedItem: FeedItem

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
                ProfileButton()
                
                NumberIconButton(icon: "heart.fill", number: 44_300)
                NumberIconButton(icon: "ellipsis.bubble.fill", number: 339)
                NumberIconButton(icon: "bookmark.fill", number: 3918)
                NumberIconButton(icon: "arrowshape.turn.up.forward.fill", number: 9219)
            }
        }
    }
}

private struct ProfileButton: View {
    var body: some View {
        Button(action: {}, label: {
            Image("mathijs")
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .clipShape(Circle())
                .overlay(alignment: .bottom) {
                    Image(systemName: "plus")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding(4)
                        .frame(width: 24, height: 24)
                        .background(.red)
                        .clipShape(Circle())
                        .offset(y: 12)
                }
        })
        .padding(.bottom, 12)
    }
}

private struct NumberIconButton: View {
    let icon: String
    let number: Int
    var body: some View {
        Button(action: {
            print("TODO")
        }, label: {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                Text(number, format: .number)
                    .font(.headline)
            }
        })
    }
}


struct FeedPageOverlay_Previews: PreviewProvider {
    static var previews: some View {
        FeedPageOverlay(feedItem: .example)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}
