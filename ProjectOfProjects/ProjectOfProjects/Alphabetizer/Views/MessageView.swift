import SwiftUI

struct MessageView: View {
    @Environment(Alphabetizer.self) private var alphabetizer

    var body: some View {
        Text(alphabetizer.message.rawValue)
            .font(.system(size: 24))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    MessageView()
        .environment(Alphabetizer())
}
