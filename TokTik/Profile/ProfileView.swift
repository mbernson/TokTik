//
//  ProfileView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text("Profile goes here")
    }
}

class ProfileViewController: UIHostingController<ProfileView> {
    init() {
        super.init(rootView: ProfileView())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#Preview {
    ProfileView()
}
