import SwiftUI
import Kingfisher

struct SongDetailView: View {
    @EnvironmentObject var musicData: CurrentMusicData
    @State private var artistDetailModel:ArtistDetailModel? = nil
    @State private var isExpanded = false

    var body: some View {
        ScrollView {
            VStack() {
                Text(musicData.currentSong?.artist ?? "Unknown Artist")
                    .font(.title)
                    .padding()

                KFImage(makeSafeURL(from: "http://49.213.238.75:8002/api/img/\(String(describing: musicData.currentSong?.artist ?? ""))/artist/"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .cornerRadius(15)
                    .padding(10)
            

                //show song
                if let artistDetailModel = artistDetailModel {
                    
                    Text(artistDetailModel.artist.first!.summary)
                                   .font(.headline)
                                   .foregroundColor(.gray)
                                   .lineLimit(isExpanded ? nil : 2) // 最多顯示兩行，如果展開則取消限制
                                   .padding(.horizontal, 20)
                                   .padding(.vertical, 10)

                               // 按鈕，當點擊時切換 isExpanded 的值
                               Button(action: {
                                   isExpanded.toggle()
                               }) {
                                   Text(isExpanded ? "收起" : "展開")
                                       .foregroundColor(.blue)
                               }
                    
                    LazyVStack(spacing: 16) {
                        ForEach(artistDetailModel.songs ) { song in
                            HStack {
                                Button(action: {
                                    musicData.Album = artistDetailModel.songs
                                    musicData.artist = song.artist
                                    musicData.music_ID = song.music_ID
                                    musicData.musicTitle = song.title
                                }) {
                                    LazyHStack(spacing: 16) {
                                        KFImage(makeSafeURL(from: "http://49.213.238.75:8002/api/img/\(song.artist)/\(song.music_ID)"))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(15)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(song.title)
                                                .font(.headline)

                                            Text(song.artist)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.vertical, 8)
                                    }
                                    .padding(.vertical, 8)
                                }

                                Spacer()
                            }
                        }
                    }
                    .padding(10)
                }
            }
        }
        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default button style
        .onAppear() {
            DispatchQueue.global().async {
                let apiManager = APIManager()
                let url = makeSafeURL(from: "http://localhost:8000/api/music/artist_test/\(String(describing: musicData.currentSong?.artist ?? ""))/")!
//                print(url)
                apiManager.fetch(url: url) { (result: Result<ArtistDetailModel, APIError>) in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.artistDetailModel = data // Use 'self' to modify the @State property
                        }
                    case .failure(let error):
                        print("API error:", error)
                    }
                }
            }
        }
    }
}
