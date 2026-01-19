import SwiftUI

struct TutorialOverlayView: View {
    let dismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            GlassmorphismContainer {
                VStack(spacing: 12) {
                    Text("Tutorial")
                        .font(.title2.bold())
                    Text("Swipe left or right to dodge barriers. Stay centered to keep your speed high.")
                        .font(.subheadline)
                    Button("Got it") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: 280)
            }
        }
    }
}
