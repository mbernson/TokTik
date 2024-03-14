//
//  FriendsView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        Text("Friends view goes here")
    }
}

class FriendsViewController: UIHostingController<FriendsView> {
    init() {
        super.init(rootView: FriendsView())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

#Preview {
    FriendsView()
}
