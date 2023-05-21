//
//  FeedDataSource.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import Foundation
import SwiftUI

struct Profile: Identifiable {
    let id: Int
    let name: String
    let picture: URL?
    let isVerified: Bool

    static let henk = Profile(id: 1, name: "Henk",
                                 picture: Bundle.main.url(forResource: "henk", withExtension: "jpg"),
                                isVerified: false)
    static let vice = Profile(id: 2, name: "Motherboard",
                                 picture: Bundle.main.url(forResource: "motherboard", withExtension: "jpg"),
                                isVerified: true)
}

struct FeedItem: Identifiable {
    let id: Int
    let description: String
    let date: Date
    let videoURL: URL?
    let user: Profile

    static let example = FeedItem(id: 1, description: "Duck Army",
                                  date: .now, videoURL: Bundle.main.url(forResource: "DuckArmy", withExtension: "mp4"),
                                                       user: .henk)
    static let examples: [FeedItem] = [
        FeedItem(
            id: 1,
                 description: "5 euro, op je muil gauw",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "5euros", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 2,
                 description: "Duck Army",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "DuckArmy", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 3,
                 description: "Nuke the entire site from orbit",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "AlienNuke", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 4,
                 description: "Google Translate naar het Frans",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "FrenchTranslate", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 5,
                 description: "Gember reveal party",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "GemberReveal", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 6,
                 description: "Hack the planet!!1!",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "HackThePlanet", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 7,
                 description: "Er was een grote storm in Nederland",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "Storm", withExtension: "mp4"),
            user: .henk
        ),
        FeedItem(
            id: 8,
                 description: "Gaaf land wonen wij toch in",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "Supergaaf", withExtension: "mp4"),
            user: .henk
        ),
    ]
}

protocol FeedDataSource {
    func nextItem() -> FeedItem?
}

class FollowingFeedDataSource: FeedDataSource {
    func nextItem() -> FeedItem? {
        return FeedItem(
            id: 8,
                 description: "Gaaf land wonen wij toch in",
                 date: .now,
            videoURL: Bundle.main.url(forResource: "Supergaaf", withExtension: "mp4"),
            user: .henk
        )
    }
}

class ForYouFeedDataSource: FeedDataSource {
    var items: [FeedItem] = []

    init() {
        self.items = FeedItem.examples.shuffled()
    }

    func nextItem() -> FeedItem? {
        guard !items.isEmpty else { return nil }
        return items.removeFirst()
    }
}

class PreviewFeedDataSource: FeedDataSource {
    var items: [FeedItem] = []

    init() {
        self.items = FeedItem.examples
    }

    func nextItem() -> FeedItem? {
        guard !items.isEmpty else { return nil }
        return items.removeFirst()
    }
}
