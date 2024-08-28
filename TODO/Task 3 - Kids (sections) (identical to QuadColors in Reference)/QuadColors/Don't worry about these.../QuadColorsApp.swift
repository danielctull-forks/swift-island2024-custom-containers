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
    @AppStorage("string") var test: String = ""

    @AppStorage("scores") var scoreData: Data = Data()

    private var scores: Binding<[Score]> {
        Binding {
            (try? JSONDecoder().decode([Score].self, from: scoreData)) ?? []
        } set: { scores in
            scoreData = try! JSONEncoder().encode(scores)
        }
    }

    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartView(startingColors: $startingColors, scores: scores)
                    .navigationTitle("Starting colors")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
