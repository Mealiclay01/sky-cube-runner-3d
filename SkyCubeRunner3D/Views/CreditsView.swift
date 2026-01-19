import SwiftUI

struct CreditsView: View {
    var body: some View {
        ScrollView {
            GlassmorphismContainer {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Credits")
                        .font(.title2.bold())
                    Text("Design & Development: Sky Cube Studio")
                    Text("Audio: Generated placeholder SFX")
                    Text("Thanks for playing Sky Cube Runner 3D!")
                }
                .foregroundStyle(.white)
            }
            .padding()
        }
        .navigationTitle("Credits")
        .background(
            LinearGradient(colors: [Color.black, Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}
