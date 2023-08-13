import SwiftUI

struct Lib: View {
    var body: some View {
         CustomNavigationView(firstView: Text("First View"), secondView: SecondView())
     }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
            .font(.headline)
            .padding()
    }
}
