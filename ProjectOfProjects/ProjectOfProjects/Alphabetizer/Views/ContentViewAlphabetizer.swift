import SwiftUI

struct ContentViewAlphabetizer: View {
    var body: some View {
        VStack(spacing: 20) {
            ScoreView()
            MessageView()
            Spacer()
            WordCanvasIphone()
            Spacer()
            SettingsViewAlphabetizer()
            SubmitButton()
            Text("Three consecutives wins clears the vocabulary set!")
                .font(.system(size: 18))
        }
        .padding(.top, 50)
    }
}

#Preview {
    ContentViewAlphabetizer()
        .environment(Alphabetizer())
}
