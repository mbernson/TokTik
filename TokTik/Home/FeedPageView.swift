//
//  FeedPageView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI
import AVKit

// This is a single page

struct FeedPageView: View {
    @ObservedObject var viewModel: FeedPageViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            PlayerView(player: viewModel.player, videoGravity: .resizeAspectFill)
                .ignoresSafeArea(.all, edges: .top)
                .onTapGesture {
                    if viewModel.player?.timeControlStatus == .playing {
                        viewModel.player?.pause()
                    } else {
                        viewModel.player?.play()
                    }
                }

            FeedPageOverlay(feedItem: viewModel.feedItem)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .opacity(viewModel.isDimmed ? 0.5 : 1.0)
        }
    }
}


class FeedPageController: UIHostingController<FeedPageView> {
    let viewModel: FeedPageViewModel
    let feedItem: FeedItem

    init(feedItem: FeedItem) {
        let viewModel = FeedPageViewModel(feedItem: feedItem)
        self.viewModel = viewModel
        self.feedItem = feedItem
        super.init(rootView: FeedPageView(viewModel: viewModel))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear(animated)
    }
}

class FeedPageViewModel: ObservableObject {
    let feedItem: FeedItem
    @Published var isDimmed = false
    let player: AVPlayer?

    init(feedItem: FeedItem) {
        self.feedItem = feedItem
        self.player = feedItem.videoURL.map { url in
            AVPlayer(url: url)
        }
    }

    func willTransition() {
        isDimmed = true
        player?.pause()
    }

    func didTransition(completed: Bool) {
        isDimmed = false

        if completed {
            player?.seek(to: .zero)
        }
        player?.play()
        print("Playing \(String(describing: feedItem.videoURL?.lastPathComponent))")
    }

    func viewWillAppear(_ animated: Bool) {
    }

    func viewDidAppear(_ animated: Bool) {
    }

    func viewWillDisappear(_ animated: Bool) {
        print("Pausing \(String(describing: feedItem.videoURL?.lastPathComponent))")
        player?.pause()
    }

    func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
}

struct FeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPageView(viewModel: FeedPageViewModel(feedItem: .example))
    }
}
