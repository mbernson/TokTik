//
//  RecordView.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        Text("Hello, World!")
    }
}


class RecordViewController: UIHostingController<RecordView> {
    init() {
        super.init(rootView: RecordView())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
