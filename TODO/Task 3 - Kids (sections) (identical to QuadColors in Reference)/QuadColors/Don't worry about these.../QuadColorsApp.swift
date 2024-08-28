//
//  QuadColorsApp.swift
//  QuadColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

@main
struct QuadColorsApp: App {

    @State var startingColors: [StartingColors] = [
        StartingColors(id: UUID().uuidString)
    ]

    @State var scores: [Score] = []

    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartView(startingColors: $startingColors, scores: $scores)
                    .navigationTitle("Starting colors")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
