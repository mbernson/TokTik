//
//  TabBar.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct TabBarItem: Identifiable {
    let id: Int
    let title: String?
    let image: UIImage?
    let selectedImage: UIImage?
}

struct TabBar: UIViewControllerRepresentable {
    let viewControllers: [UIViewController] = [
        HomeViewController(),
        FriendsViewController(),
        RecordViewController(),
        InboxViewController(),
        ProfileViewController(),
    ]

    let tabs: [TabBarItem] = [
        TabBarItem(id: 1, title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill")),
        TabBarItem(id: 2, title: "Vrienden", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill")),
        TabBarItem(id: 3, title: nil, image: UIImage(named: "create_button"), selectedImage: UIImage(named: "create_button")),
        TabBarItem(id: 4, title: "Inbox", image: UIImage(systemName: "bubble.middle.bottom"), selectedImage: UIImage(systemName: "bubble.middle.bottom.fill")),
        TabBarItem(id: 5, title: "Profiel", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill")),
    ]

    func makeUIViewController(context: Context) -> TabBarController {
        let tabBarController = TabBarController()
        tabBarController.setViewControllers(viewControllers, animated: false)
        tabBarController.tabBar.tintColor = .white
        let blackAppearance = UITabBarAppearance()
        blackAppearance.configureWithOpaqueBackground()
        blackAppearance.backgroundColor = .black

        for (i, item) in tabs.enumerated() {
            let tabBarItem = UITabBarItem(title: item.title, image: item.image, tag: item.id)
            tabBarItem.selectedImage = item.selectedImage
            tabBarItem.standardAppearance = blackAppearance
            tabBarItem.scrollEdgeAppearance = blackAppearance
            viewControllers[i].tabBarItem = tabBarItem
        }

        for controller in viewControllers {
            controller.loadViewIfNeeded()
        }

        tabBarController.delegate = context.coordinator
        return tabBarController
    }

    func updateUIViewController(_ viewController: TabBarController, context: Context) {
        //
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(tabs: tabs)
    }

    class Coordinator: NSObject, UITabBarControllerDelegate {
        let tabs: [TabBarItem]

        init(tabs: [TabBarItem]) {
            self.tabs = tabs
        }

        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            guard let tab = tabs.first(where: { $0.id == viewController.tabBarItem.tag }) else { return }
            print("Switched tab to \(tab.title ?? "untitled tab")")
        }
    }
}

class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Customize tab bar controller here
    }
}

#Preview {
    TabBar()
        .ignoresSafeArea()
}
