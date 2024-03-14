//
//  SourcePicker.swift
//  TokTik
//
//  Created by Mathijs Bernson on 19/05/2023.
//

import SwiftUI

struct SourcePicker: View {
    let sources: [FeedSource]
    @Binding var selectedSource: FeedSource
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 20) {
            ForEach(sources) { source in
                let isSelected = (source.id == selectedSource.id)
                Button {
                    withAnimation(.spring().speed(1.5)) {
                        selectedSource = source
                    }
                } label: {
                    HStack {
                        VStack {
                            Text(source.title)
                                .font(.headline)
                                .opacity(isSelected ? 1.0 : 0.5)
                                .overlay(alignment: .bottom) {
                                    if isSelected {
                                        Rectangle()
                                            .fill(.foreground)
                                            .frame(height: 4)
                                            .padding(.horizontal, 20)
                                            .offset(y: 10)
                                            .matchedGeometryEffect(id: "lijntje", in: animation, isSource: isSelected)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct SourcePicker_Preview: View {
    let sources: [FeedSource] = [.following, .forYou]
    @State var selectedSource: FeedSource = .forYou

    var body: some View {
        SourcePicker(sources: sources, selectedSource: $selectedSource)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
    }
}

#Preview {
    SourcePicker_Preview()
}
