import SwiftUI

struct ScoreView: View {
    @Environment(Alphabetizer.self) private var alphabetizer

    //private var percentage = alphabetizer.score / alphabetizer.attempts * 100

    var body: some View {
        Text("Score: \(alphabetizer.score)")
            .font(.title)
            .foregroundStyle(Color.purple)
            .bold()
        Text("Attemtps: \(alphabetizer.attempts)")
            .font(.title2)
            .foregroundStyle(Color.purple)
        Text(
            "Win percentage: \(alphabetizer.getWinPercentage)%")
        .font(.title3)
        .foregroundStyle(Color.purple)

    }
}

#Preview {
    ScoreView()
        .environment(Alphabetizer())
}
