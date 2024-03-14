//
//  FeedPaginationView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI
import os.log

struct FeedPaginationView: UIViewControllerRepresentable {
    let dataSource: FeedDataSource

    func makeUIViewController(context: Context) -> UIPageViewController {
        let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical)
        controller.delegate = context.coordinator
        controller.dataSource = context.coordinator
        context.coordinator.setInitialViewController(controller, animated: false)
        return controller
    }

    func updateUIViewController(_ controller: UIPageViewController, context: Context) {
        context.coordinator.dataSource = dataSource
        context.coordinator.setInitialViewController(controller, animated: false)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(dataSource: dataSource)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var dataSource: FeedDataSource
        private var data: [FeedItem] = []
        private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "FeedPaginationViewCoordinator")

        init(dataSource: FeedDataSource) {
            self.dataSource = dataSource
            super.init()
        }

        private func nextItem() -> FeedItem? {
            guard let item = dataSource.nextItem() else { return nil }
            data.append(item)
            return item
        }

        private func makeViewController(for feedItem: FeedItem) -> FeedPageController {
            FeedPageController(feedItem: feedItem)
        }

        func setInitialViewController(_ pageViewController: UIPageViewController, animated: Bool) {
            data.removeAll()
            guard let initialFeedItem = nextItem() else { return }
            let viewController = makeViewController(for: initialFeedItem)
            pageViewController.setViewControllers([viewController], direction: .forward, animated: animated)
            viewController.viewModel.didTransition(completed: true)
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let controller = viewController as! FeedPageController
            let index = data.firstIndex(where: { $0.id == controller.feedItem.id })!
            let previousIndex = index - 1
            if data.indices.contains(previousIndex) {
                let previousFeedItem = data[previousIndex]
                return makeViewController(for: previousFeedItem)
            } else {
                return nil
            }
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let controller = viewController as! FeedPageController
            let index = data.firstIndex(where: { $0.id == controller.feedItem.id })!
            let nextIndex = index + 1
            if data.indices.contains(nextIndex) {
                let nextFeedItem = data[nextIndex]
                return makeViewController(for: nextFeedItem)
            } else if let nextFeedItem = nextItem() {
                return makeViewController(for: nextFeedItem)
            } else {
                return nil
            }
        }

        func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
            guard let currentViewController = pageViewController.viewControllers?.first as? FeedPageController,
                  let nextViewController = pendingViewControllers.first as? FeedPageController
            else { return }
            logger.debug("Will transition to feed item \(nextViewController.feedItem.id)")
            currentViewController.viewModel.willTransition()
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            // Use the completed parameter to distinguish between a transition that completed (the page was turned) and a transition that the user aborted (the page was not turned).
            guard let nextViewController = pageViewController.viewControllers?.first as? FeedPageController,
                  let previousViewController = previousViewControllers.first as? FeedPageController
            else { return }
            nextViewController.viewModel.didTransition(completed: completed)
            if completed {
                logger.debug("Stop playing feed item \(previousViewController.feedItem.id)")
                logger.debug("Start playing feed item \(nextViewController.feedItem.id)")
            } else {
                // Do nothing
            }
        }
    }
}

#Preview {
    TabView {
        FeedPaginationView(dataSource: PreviewFeedDataSource())
            .ignoresSafeArea(edges: .top)
            .foregroundColor(.white)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Feed")
            }
    }
    .preferredColorScheme(.dark)
}
