//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

extension ContainerValues {
    @Entry var isCorrect: Bool = false
    @Entry var hint: Int?
}

extension View {

    func isCorrect(_ value: Bool) -> some View {
        containerValue(\.isCorrect, value)
    }

    func hint(_ value: Int?) -> some View {
        containerValue(\.hint, value)
            .overlay {
                if let value {
                    Text("\(value)")
                }
            }
    }
}

struct ColorsList<Content: View>: View {
    let easyMode: Bool
    let content: Content

    init(easyMode: Bool = false, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.easyMode = easyMode
    }

    var stack: some View {
        VStack(spacing: 0) {
            ForEach(subviews: content) { subview in
                subview
                    .frame(width: 60, height: 60)
                    .allowsHitTesting(subview.containerValues.hint == nil || !subview.containerValues.isCorrect)
                    .overlay(alignment: .bottomTrailing) {
                        if subview.containerValues.hint == nil && subview.containerValues.isCorrect {
                            Image(systemName: "checkmark")
                                .padding(6)
                        }
                    }
            }
        }
    }

    var body: some View {
        stack
            .border(Color.gray, width: 4)
    }
}
