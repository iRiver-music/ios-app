import SwiftUI
struct MusicPlayerView: View {
    @EnvironmentObject var musicData: CurrentMusicData
    @StateObject private var musicPlayer = MusicPlayer()
    private let songFetcher = SongFetcher()

 
    @State var isShow: Bool? = nil
    @State var isFetchingSong: Bool = false
    @Binding var isExpanded: Bool
  
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                MiniMusicPlayerView(onExpand: {
                    withAnimation {
                        isExpanded = true
                    }
                })
                .environmentObject(musicData)
                .environmentObject(musicPlayer)
                .frame(height: 180)
                .gesture(TapGesture().onEnded {
                    withAnimation {
                        isExpanded = true
                    }
                })

                if isExpanded {
                    FullMusicPlayerView(onClose: {
                        withAnimation {
                            isExpanded = false
                        }
                    })
                    .environmentObject(musicData)
                    .environmentObject(musicPlayer)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.25))
                }
            }
        }
        .statusBar(hidden: true)
        .onChange(of: musicData.music_ID) { newData in
            isFetchingSong = false
            musicPlayer.isPlaying = false
            musicPlayer.songURL = nil
            musicPlayer.player?.pause()
            fetchSong()
        }
    }

    private func fetchSong() {
        guard !isFetchingSong else { return } // 如果正在获取歌曲，则不执行

        isFetchingSong = true // 开始获取新歌曲

        // 在获取完成后，将 isFetchingSong 设置为 false
        songFetcher.fetchSong(artist: musicData.artist, music_ID:musicData.music_ID){ result in
            isFetchingSong = false // 获取完成后将其设置为 false

            // 处理获取的歌曲数据
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    musicPlayer.songURL = url
                    musicPlayer.start()
                    musicPlayer.player?.play()
                    musicPlayer.isPlaying = true
    
                }
            case .failure(let error):
                print("Error fetching song:", error)
            }
        }
    }


//    private func fetchImage() {
//        songFetcher.fetchImage(artist: musicData.artist, music_ID: musicData.music_ID) { result in
//            switch result {
//            case .success(let url):
//                DispatchQueue.main.async {
////                    musicPlayer.imageURL = url
//                    imageURL = url
//                }
//            case .failure(let error):
//                print("Error fetching image:", error)
//            }
//        }
//    }
}


//struct MusicPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicPlayerView()
//    }
//}
