//
//  HomeView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let dataSource: FeedDataSource

    init() {
        self.dataSource = ForYouFeedDataSource()
    }
}

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        FeedPaginationView(dataSource: viewModel.dataSource)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "play.tv")
                    })
                    Spacer()
                    SourcePicker()
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

struct FeedSource: Identifiable {
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
