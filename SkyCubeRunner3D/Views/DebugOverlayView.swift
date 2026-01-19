import SwiftUI

struct DebugOverlayView: View {
    let info: DebugInfo

    var body: some View {
        GlassmorphismContainer {
            VStack(alignment: .leading, spacing: 6) {
                Text("FPS: \(String(format: "%.0f", info.fps))")
                Text("Nodes: \(info.nodeCount)")
                Text("Speed: \(String(format: "%.1f", info.speed))")
                Text("Pool: \(info.poolSize)")
            }
            .font(.caption)
            .foregroundStyle(.white)
        }
    }
}
