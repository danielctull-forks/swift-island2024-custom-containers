import SwiftUI

struct Score: Identifiable, Codable {
    let id: String
    let name: String
    let time: TimeInterval

    var duration: Duration { .seconds(time) }
}

struct Scoreboard: View {

    init(scores: [Score]) {
        self.scores = scores.sorted(by: { $0.time < $1.time })
    }

    let scores: [Score]

    var body: some View {
        List(scores) { score in
            LabeledContent {
                Text(score.duration, format: .time(pattern: .minuteSecond))
            } label: {
                Text(score.name)
            }
        }
    }
}
