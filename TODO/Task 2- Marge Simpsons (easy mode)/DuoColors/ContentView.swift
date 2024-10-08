//
//  ContentView.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var easyMode: Bool
    @Binding var colors: [ColorModel]

    var body: some View {
        VStack {
            customContainerContent
            variadicViewFooter
        }
    }

    var variadicViewFooter: some View {
        _VariadicView.Tree(FooterVStackLayout(alignment: .leading)) {
            Toggle("Easy Mode", isOn: $easyMode)
            Text("Start with first and last tiles locked in place, some tiles with a hint, and a checkmark when a tile is in the right spot")
                .font(.caption)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding([.horizontal, .top])
    }

    var customContainerContent: some View {
        ColorsList(easyMode: easyMode) {

            /// If `easyMode` is `true`, then we should show the first and last colors,
            /// separately from the `ReorderableForEach`. This means they will be "stuck" (can't
            /// drag them), and the game will start when they are in the correct place.
            /// So we want to:
            /// - Check if we are in easy mode.
            /// - If we are - grab the first/last item - use `ColorMode.initialColors.first/last`
            /// - Show item.color
            /// - Set `isCorrect(true)`, and the color hint value


            if easyMode, let item = ColorModel.initialColors.first {
                item.color
                    .isCorrect(true)
                    .hint(item.id)
            }

            ReorderableForEach(items: colors, itemHeight: 60) { item in
                item.color
                    .isCorrect(isCorrect(item))
                    .hint(item.hint ? item.id : nil)
            } moveAction: { from, to in
                colors.move(fromOffsets: .init(integer: from), toOffset: to)
            }

            if easyMode, let item = ColorModel.initialColors.last {
                item.color
                    .isCorrect(true)
                    .hint(item.id)
            }
        }
    }

    func isCorrect(_ item: ColorModel) -> Bool {
        return colors.firstIndex(of: item)! + 1 + (easyMode ? 1 : 0) == item.id
    }
}
