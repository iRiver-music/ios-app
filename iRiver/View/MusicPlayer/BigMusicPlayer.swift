import SwiftUI
import Kingfisher

struct FullMusicPlayerView: View {
    var onClose: () -> Void
    
    @GestureState private var dragOffset = CGSize.zero
    @State private var isFading = false
    
    @EnvironmentObject var musicData: CurrentMusicData
    @EnvironmentObject private var musicPlayer: MusicPlayer

    
    var body: some View {
        VStack {
            Spacer()
            // 照片

            KFImage(makeSafeURL(from: "http://49.213.238.75:8002/api/img/\(musicData.artist)/\(musicData.music_ID)/"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 300)
            // Title
            VStack {
                Text(musicData.musicTitle)
                Text(musicData.artist)
            }
            .font(.title)
            .padding()

            // Button事件
            HStack(spacing: 30) {
                // Pre
                Button(action: {
                    playPreviousSong()
                }) {
                    Image(systemName: "chevron.backward.to.line")
                }

                // Play and Pause
                Button(action: {
                    musicPlayer.togglePlayback()
                }) {
                    Image(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 60))
                }

                // Next
                Button(action: {
                    playNextSong()
                }) {
                    Image(systemName: "chevron.forward.to.line")
                }
            }
            .font(.system(size: 30))
            .padding()

            // 进度条
            DateRelativeProgressDemoView(totalDuration: $musicPlayer.totalDuration, currentTime: $musicPlayer.currentTime)
                .environmentObject(musicPlayer)
                .disabled(musicPlayer.songURL == nil)
            Spacer()
        }
        .disabled(musicPlayer.songURL == nil)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(opacityValue(for: dragOffset.height)))
        .edgesIgnoringSafeArea(.all)
        .offset(y: dragOffset.height)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, dragOffset, _ in
                    dragOffset = value.translation
                }
                .onChanged { _ in
                    withAnimation {
                        isFading = true
                    }
                }
                .onEnded { value in
                    let velocity = value.predictedEndTranslation.height / value.predictedEndLocation.y
                    if value.translation.height > 200 && velocity < 100 {
                        onClose()
                    } else {
                        withAnimation(.linear(duration: Double(velocity))) {
                            isFading = false
                        }
                    }
                }
        )
        .onChange(of: musicPlayer.isDone) { newValue in
            if newValue {
                playNextSong()
                musicPlayer.isDone = false
            }
        }
    }
    
    private func playNextSong() {
        guard !musicData.music_ID.isEmpty else {
            // Current song doesn't exist
            return
        }
        
        guard let currentIndex = musicData.Album.firstIndex(where: { $0.music_ID == musicData.music_ID }) else {
            // Current song index not found in the Album array
            return
        }
        
        let albumLength = musicData.Album.count
        let nextIndex = (currentIndex + 1) % albumLength
        
        let nextSong = musicData.Album[nextIndex]
        let nextSongTitle = nextSong.title
        let nextSongArtist = nextSong.artist
        let nextSongID = nextSong.music_ID
        
        // Update the relevant properties
        musicData.musicTitle = nextSongTitle
        musicData.artist = nextSongArtist
        musicData.music_ID = nextSongID
    }

    
    private func playPreviousSong() {
        guard !musicData.music_ID.isEmpty else {
            // Current song doesn't exist
            return
        }
        
        guard let currentIndex = musicData.Album.firstIndex(where: { $0.music_ID == musicData.music_ID }) else {
            // Current song index not found in the Album array
            return
        }
        
        let albumLength = musicData.Album.count
        let previousIndex = (currentIndex - 1 + albumLength) % albumLength
        
        let previousSong = musicData.Album[previousIndex]
        let previousSongTitle = previousSong.title
        let previousSongArtist = previousSong.artist
        let previousSongID = previousSong.music_ID
        
        // Update the relevant properties
        musicData.musicTitle = previousSongTitle
        musicData.artist = previousSongArtist
        musicData.music_ID = previousSongID
    }



    private func opacityValue(for dragHeight: CGFloat) -> Double {
        let threshold: CGFloat = 700
        let normalizedDragHeight = min(max(dragHeight, 0), threshold)
        let opacity = Double(normalizedDragHeight / threshold)
        return 1 - opacity
    }
}
