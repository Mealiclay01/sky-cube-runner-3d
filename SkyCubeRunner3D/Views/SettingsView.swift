import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: SettingsStore

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GlassmorphismContainer {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("Sound Effects", isOn: $settings.audioEnabled)
                        Toggle("Music", isOn: $settings.musicEnabled)
                        Toggle("Haptics", isOn: $settings.hapticsEnabled)
                    }
                }

                GlassmorphismContainer {
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle("High Contrast", isOn: $settings.highContrast)
                        Toggle("Debug Overlay", isOn: $settings.showDebug)
                        Toggle("Show Tutorial", isOn: $settings.showTutorial)
                    }
                }

                GlassmorphismContainer {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Dynamic Type")
                            .font(.headline)
                        Text("Sky Cube Runner 3D scales text automatically. Use iOS Settings > Accessibility > Display & Text Size to adjust.")
                            .font(.footnote)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Settings")
        .background(
            LinearGradient(colors: [Color.black, Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}
