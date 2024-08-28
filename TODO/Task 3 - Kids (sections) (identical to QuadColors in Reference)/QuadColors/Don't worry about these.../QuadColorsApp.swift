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

    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartView(startingColors: $startingColors)
                    .navigationTitle("Starting colors")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
