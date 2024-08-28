import SwiftUI

struct StartingColors: Identifiable {
    let id: String
    var topLeft: Color = .red
    var topRight: Color = .blue
    var bottomLeft: Color = .green
    var bottomRight: Color = .yellow
}

struct StartingColorsPicker: View {

    @Environment(\.dismiss) private var dismiss
    @State private var startingColors = StartingColors(id: UUID().uuidString)
    let completion: (StartingColors) -> Void

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ColorPicker("Top Left", selection: $startingColors.topLeft)
                    Spacer()
                    ColorPicker("Top Right", selection: $startingColors.topRight)
                }
                Spacer()
                HStack(spacing: 0) {
                    ColorPicker("Bottom Left", selection: $startingColors.bottomLeft)
                    Spacer()
                    ColorPicker("Bottom Right", selection: $startingColors.bottomRight)
                }
            }
            .frame(width: 100, height: 100)
            .padding()

            Button("Done") {
                completion(startingColors)
                dismiss()
            }
        }
        .labelsHidden()
    }
}
