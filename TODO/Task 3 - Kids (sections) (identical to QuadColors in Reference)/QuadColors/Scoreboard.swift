import SwiftUI

struct Score: Identifiable {
    let id: String
    let name: String
    let time: TimeInterval
}

struct Scoreboard: View {

    init(scores: [Score]) {
        self.scores = scores.sorted(by: { $0.time > $1.time })
    }

    let scores: [Score]

    var body: some View {
        List(scores) { score in
            HStack {
                Text(score.name)
                Text("\(score.time)")
            }
        }
    }
}
