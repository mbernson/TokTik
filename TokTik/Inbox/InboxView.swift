//
//  InboxView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI
import Combine

class InboxViewModel: ObservableObject {
    @Published var unreadBadgeCount: Int = 7
}

struct InboxView: View {
    @ObservedObject var viewModel: InboxViewModel

    var body: some View {
        NavigationStack {
            List {
                Text("Inbox goes here")
            }
            .navigationTitle("Inbox")
        }
    }
}

class InboxViewController: UIHostingController<InboxView> {
    let viewModel: InboxViewModel
    private var disposeBag = Set<AnyCancellable>()

    init() {
        let viewModel = InboxViewModel()
        self.viewModel = viewModel
        super.init(rootView: InboxView(viewModel: viewModel))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$unreadBadgeCount
            .map(String.init)
            .assign(to: \.badgeValue, on: tabBarItem)
            .store(in: &disposeBag)
    }
}

#Preview {
    InboxView(viewModel: InboxViewModel())
}
