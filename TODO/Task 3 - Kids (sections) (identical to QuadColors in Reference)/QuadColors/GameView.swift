import SwiftUI

struct Game: View {

    private let startTime: Date
    private let startingColors: StartingColors
    private let initialColors: [[ColorModel]]
    private let completion: (Score) -> Void

    init(startingColors: StartingColors, completion: @escaping (Score) -> Void) {
        self.startTime = Date()
        self.completion = completion
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
    @State private var didWin = false
    @State private var name: String = ""
    @State private var endTime = Date()

    func updateColors() {
        colors = initialColors.map { $0.shuffled() }
    }
    
    var body: some View {
        ContentView(colors: $colors)
            .onAppear {
                updateColors()
            }
            .sheet(isPresented: $didWin) {
                VStack {
                    Text("Amazing! 🎉")
                        .font(.largeTitle)

                    TextField("Name", text: $name)

                    Button {
                        didWin = false
                        let score = Score(
                            id: UUID().uuidString,
                            name: name,
                            time: endTime.timeIntervalSince(startTime)
                        )
                        completion(score)
                    } label: {
                        Text("Submit Score")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding()
                            .background {
                                Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 4))
                            }
                    }
                }
                .padding()
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
                endTime = Date()
            }
            .onChange(of: didWin) { oldValue, newValue in
                guard oldValue != newValue else { return }
                if !newValue {
                    updateColors()
                }
            }
    }
}
