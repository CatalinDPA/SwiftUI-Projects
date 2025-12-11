import SwiftUI

struct SubmitButton: View {
    @Environment(Alphabetizer.self) private var alphabetizer

    var isEnabled: Bool {
        alphabetizer.message == .instructions
    }

    var body: some View {
        //Ipad
        /*Button {
            alphabetizer.submit()
        } label: {
            Image(systemName: "play.circle")
                .font(.system(size: 60))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 80)
                .padding(.vertical, 20)
                .background(RoundedRectangle(cornerRadius: 30)
                    .fill(Color.purple)
                    .opacity(isEnabled ? 1.0 : 0.5)
                )
        }
        .animation(.default, value: isEnabled)
        .disabled(!isEnabled)*/

        //Iphone
        Button {
            alphabetizer.submit()
        } label: {
            Image(systemName: "play.circle")
                .font(.system(size: 30))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
                .background(RoundedRectangle(cornerRadius: 30)
                    .fill(Color.purple)
                    .opacity(isEnabled ? 1.0 : 0.5)
                )
        }
        .animation(.default, value: isEnabled)
        .disabled(!isEnabled)
    }
}

#Preview {
    SubmitButton()
        .environment(Alphabetizer())
}
