import SwiftUI

struct DateRelativeProgressDemoView: View {
    @Binding var totalDuration: Double
    @Binding var currentTime: Double

    @State private var isInitialLoad = true
    @EnvironmentObject private var musicPlayer: MusicPlayer

    var currentProgress: Double {
        return currentTime / totalDuration
    }

    var formattedTime: String {
        let minutes = Int(currentTime) / 60
        let seconds = Int(currentTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack {
            Slider(value: Binding(
                get: { currentProgress },
                set: { value in
                    let newCurrentTime = value * totalDuration
                    currentTime = min(max(0, newCurrentTime), totalDuration)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        musicPlayer.updateCurrentTime(currentTime)
                    }
                }
            ), in: 0...1)

            HStack {
                Spacer()
                Text(formattedTime)
                    .font(.body)
                    .padding(4)
                    .cornerRadius(8)
            }
            .alignmentGuide(.bottom) { dimensions in
                dimensions[.bottom] + 8 // Adjust the distance from the bottom
            }
        }
        .padding()
        .onChange(of: currentTime) { _ in
            isInitialLoad = false
        }
    }
}
