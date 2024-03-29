//
//  HomeView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    var dataSource: FeedDataSource

    let sources: [FeedSource] = [.following, .forYou]

    @Published var selectedSource: FeedSource = .forYou {
        didSet {
            dataSource = dataSource(for: selectedSource)
            objectWillChange.send()
        }
    }

    init() {
        self.dataSource = ForYouFeedDataSource()
    }

    func dataSource(for feedSource: FeedSource) -> FeedDataSource {
        switch feedSource {
        case .following:
            return FollowingFeedDataSource()
        case .forYou:
            return ForYouFeedDataSource()
        default:
            fatalError()
        }
    }
}

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        FeedPaginationView(dataSource: viewModel.dataSource)
            .ignoresSafeArea(edges: .top)
            .overlay(alignment: .top) {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "play.tv")
                    })
                    Spacer()
                    SourcePicker(sources: viewModel.sources, selectedSource: $viewModel.selectedSource)
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                    })
                }
                .padding()
                .font(.title2)
            }
            .foregroundColor(.white)
    }
}

struct FeedSource: Identifiable, Equatable {
    let id: Int
    let title: String
    let hasDot: Bool

    static let following = FeedSource(id: 1, title: "Volgend", hasDot: true)
    static let forYou = FeedSource(id: 2, title: "Voor jou", hasDot: false)
}

class HomeViewController: UIHostingController<HomeView> {
    init() {
        super.init(rootView: HomeView())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#Preview {
    HomeView()
}
