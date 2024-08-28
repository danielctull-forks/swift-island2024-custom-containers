import SwiftUI

struct StartView: View {

    @Binding var startingColors: [StartingColors]
    @State private var presented = false

    var body: some View {
        List(startingColors) { colors in
            Cell(startingColors: colors)
        }
        .toolbar {
            Button("+") {
                presented = true
            }
        }
        .sheet(isPresented: $presented) {
            StartingColorsPicker { colors in
                startingColors.append(colors)
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

