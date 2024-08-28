//
//  ContentView.swift
//  QuadColors
//
//  Created by Aviel Gross on 10.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var colors: [[ColorModel]]

    var body: some View {
        VStack {
            content
        }
    }

    var content: some View {
        ColorsList {
            ForEach(colors.indices, id: \.self) { index in
                Section {
                    sectionContent(at: index)
                }
            }
        }
    }

    func sectionContent(at index: Int) -> some View {
        ReorderableForEach(items: colors[index], itemHeight: 60) { item in
            item.color
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: radius(
                            row: item.order,
                            rowCount: colors[index].count,
                            column: item.column,
                            columnCount: colors.count,
                            size: 60
                        )
                    )
                )
        } moveAction: { from, to in
            colors[index].move(fromOffsets: .init(integer: from), toOffset: to)
        }
    }
}

func radius(
    row: Int,
    rowCount: Int,
    column: Int,
    columnCount: Int,
    size: CGFloat
) -> CGFloat {
    let id = row + 1 + column + 1
    let total = rowCount + columnCount
    let value = CGFloat(id) / CGFloat(total)
    return value * size / 2
}
