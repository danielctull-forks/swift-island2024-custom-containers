import SwiftUI

struct StartView: View {

    @Binding var startingColors: [StartingColors]
    @Binding var scores: [Score]
    @State private var presentStartingColors = false
    @State private var presentScores = false

    var body: some View {
        List(startingColors) { colors in
            NavigationLink {
                Game(startingColors: colors) { scores.append($0) }
            } label: {
                Cell(startingColors: colors)
                    .frame(height: 80)
            }
        }
        .toolbar {
            Button("Add", systemImage: "plus") {
                presentStartingColors = true
            }

            Button("Scores") {
                presentScores = true
            }
        }
        .sheet(isPresented: $presentStartingColors) {
            StartingColorsPicker { colors in
                startingColors.append(colors)
            }
        }
        .sheet(isPresented: $presentScores) {
            NavigationStack {
                Scoreboard(scores: scores)
                    .navigationTitle("Scoreboard")
            }
        }
    }

    struct Cell: View {
        let startingColors: StartingColors
        var body: some View {
            MeshGradient(
                width: 2,
                height: 2,
                points: [
                    [0, 0], [1, 0],
                    [0, 1], [1, 1]
                ],
                colors: [
                    startingColors.topLeft,
                    startingColors.topRight,
                    startingColors.bottomLeft,
                    startingColors.bottomRight,
                ])
        }
    }
}

