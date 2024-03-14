//
//  FeedPageView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI
import AVKit
import Combine

// This is a single page

struct FeedPageView: View {
    @ObservedObject var viewModel: FeedPageViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            PlayerView(player: viewModel.player, videoGravity: .resizeAspectFill)
                .ignoresSafeArea(.all, edges: .top)
                .onTapGesture {
                    if viewModel.isPaused {
                        viewModel.play()
                    } else {
                        viewModel.pause()
                    }
                }

            if viewModel.isPaused {
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .opacity(0.7)
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

@MainActor class FeedPageViewModel: ObservableObject {
    let feedItem: FeedItem
    let player: AVPlayer?

    @Published var isDimmed = false
    @Published var status: PlaybackStatus = .pending

    var isPaused: Bool { status == .paused }

    private var disposeBag = Set<AnyCancellable>()

    enum PlaybackStatus: String {
        case pending
        case playing
        case paused
    }

    init(feedItem: FeedItem) {
        self.feedItem = feedItem
        self.player = feedItem.videoURL.map { url in
            AVPlayer(url: url)
        }

        player?.publisher(for: \.timeControlStatus)
            .compactMap(convertTimeControlStatus)
            .receive(on: RunLoop.main)
            .assign(to: \.status, on: self)
            .store(in: &disposeBag)
    }

    private func convertTimeControlStatus(_ status: AVPlayer.TimeControlStatus) -> PlaybackStatus? {
        switch status {
        case .paused: .paused
        case .playing: .playing
        case .waitingToPlayAtSpecifiedRate: .pending
        @unknown default: nil
        }
    }

    func pause() {
        player?.pause()
    }

    func play() {
        player?.play()
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
        // Empty for now
    }

    func viewDidAppear(_ animated: Bool) {
        // Empty for now
    }

    func viewWillDisappear(_ animated: Bool) {
        player?.pause()
    }

    func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
}

#Preview {
    FeedPageView(viewModel: FeedPageViewModel(feedItem: .example))
        .foregroundColor(.white)
}
