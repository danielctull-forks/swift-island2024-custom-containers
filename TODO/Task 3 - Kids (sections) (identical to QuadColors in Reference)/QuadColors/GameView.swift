import SwiftUI

struct Game: View {
    
    let startingColors: StartingColors

    init(startingColors: StartingColors) {
        self.startingColors = startingColors
        self.initialColors = [[ColorModel]].random(
            topLeft: startingColors.topLeft,
            topRight: startingColors.topRight,
            bottomLeft: startingColors.bottomLeft,
            bottomRight: startingColors.bottomRight)
        self.colors = colors
        self.didWin = didWin
    }

    @State private var colors: [[ColorModel]] = []
    
    let initialColors: [[ColorModel]]
    
    @State private var didWin = false
    
    
    func updateColors() {
        colors = initialColors.map { $0.shuffled() }
    }
    
    var body: some View {
        ContentView(colors: $colors)
            .onAppear {
                updateColors()
            }
            .sheet(isPresented: $didWin) {
                Text("Amazing! 🎉")
                    .font(.largeTitle)
                Button {
                    didWin = false
                } label: {
                    Text("Play Again")
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding()
                        .background {
                            Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                }
            }
            .onChange(of: colors) { oldValue, newValue in
                guard oldValue != newValue else { return }
                
                var allInOrder = true
                var allInReverse = true
                for index in 0..<colors.count {
                    let initialIDs = initialColors[index].map { $0.id }
                    let resultIDs = colors[index].map { $0.id }
                    if initialIDs != resultIDs {
                        allInOrder = false
                    }
                    if initialIDs.reversed() != resultIDs {
                        allInReverse = false
                    }
                }
                
                didWin = allInOrder || allInReverse
            }
            .onChange(of: didWin) { oldValue, newValue in
                guard oldValue != newValue else { return }
                if !newValue {
                    updateColors()
                }
            }
    }
}
