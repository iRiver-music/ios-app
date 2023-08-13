import SwiftUI
import Kingfisher

struct MiniMusicPlayerView: View {
    var onExpand: () -> Void
    @EnvironmentObject var musicData: CurrentMusicData
    @EnvironmentObject private var musicPlayer: MusicPlayer


 

    var isPlaying: Bool = true
    
    var body: some View {
        VStack {
            HStack {
             
                KFImage(makeSafeURL(from: "http://49.213.238.75:8002/api/img/\(musicData.artist)/\(musicData.music_ID)/"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .frame(width: 65)
            
                
           
                VStack(alignment: .leading) {
                    Text(musicData.musicTitle)
                        .font(.headline)
                    
                    Text(musicData.artist)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {
                    musicPlayer.togglePlayback()
                }) {
                    Image(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 30))
                }.disabled(musicPlayer.songURL == nil)
            }
            .padding()
            .background(Color.gray.opacity(0.85))
        }
    }
}
