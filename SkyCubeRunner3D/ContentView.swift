import SwiftUI

struct ContentView: View {
    @ObservedObject var engine: GameEngine

    var body: some View {
        NavigationStack {
            MainMenuView(engine: engine)
        }
    }
}
