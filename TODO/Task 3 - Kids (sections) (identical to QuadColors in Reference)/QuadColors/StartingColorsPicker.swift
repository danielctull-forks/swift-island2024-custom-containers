import SwiftUI

struct StartingColors: Identifiable {
    let id: String
    var topLeft: Color = .red
    var topRight: Color = .blue
    var bottomLeft: Color = .green
    var bottomRight: Color = .yellow
}

struct StartingColorsPicker: View {

    @Binding var startingColors: StartingColors

    var body: some View {
        VStack {
            HStack {
                ColorPicker("Top Left", selection: $startingColors.topLeft)
                Spacer()
                ColorPicker("Top Right", selection: $startingColors.topRight)
            }
            Spacer()
            HStack {
                ColorPicker("Bottom Left", selection: $startingColors.bottomLeft)
                Spacer()
                ColorPicker("Bottom Right", selection: $startingColors.bottomRight)
            }
        }
    }
}
