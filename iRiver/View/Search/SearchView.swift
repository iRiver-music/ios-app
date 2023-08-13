import SwiftUI
import Kingfisher

struct SearchView: View {
    @EnvironmentObject var musicData: CurrentMusicData
    
    @EnvironmentObject var currentData: CurrentData
    @State private var songs: [SongModel] = []
    
    @State private var isShowingSongDetail: Bool = false // State to control whether to show SongDetailView
    @State private var selectedSong: SongModel? // State to store the selected SongModel
    @State private var isActivate = false
    
    
    var body: some View {
        VStack {
            // 将闭包传递给SearchBar，当按下确认键时执行特定操作
            ZStack(alignment: .top) { // Use ZStack to stack the content and align them to the top
                VStack {
                    
                  
                    // 将闭包传递给SearchBar，当按下确认键时执行特定操作
                    SearchBar(text: $currentData.searchText, onCommit: handleSearchCommit)
                
                }
            }
            
            if isActivate { // Optional binding to safely unwrap the songs array
                List {
                    ForEach(songs) { song in
                        HStack{
                            Button(action: {
                                selectedSong = song // Store the selected SongModel
                                musicData.Album = songs
                                
                                //                             Uncomment and modify if you need to pass more data to SongDetailView
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
                            
                            // Details button to open SongDetailView
                            Button(action: {
                                selectedSong = song
                                musicData.currentSong = song
                                isShowingSongDetail = true // Show SongDetailView
                            }) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                            .padding(10)
                            
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default button style
                .sheet(isPresented: $isShowingSongDetail, onDismiss: {
                    // Code to run when SongDetailView is dismissed
                    selectedSong = nil // Clear selectedSong when SongDetailView is dismissed
                }) {
                    if selectedSong != nil {
                        TempView()
                            .environmentObject(musicData)
                    }
                }
            }
        }
    }
    
    // 在这里添加搜索结果列表或其他内容



    // 处理按下确认键的事件
    private func handleSearchCommit() {
        DispatchQueue.global().async {
            let apiManager = APIManager()
            let urlString = "http://49.213.238.75:5001/api/music/query/db/\(currentData.searchText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let url = URL(string: urlString)!

            apiManager.fetch(url: url) { (result: Result<[SongModel], APIError>) in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        songs = data
                        isActivate = true
                    }
                case .failure(let error):
                    print("API error:", error)
                }
            }
        }
    }
}


struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false
    var onCommit: (() -> Void)? = nil


    var body: some View {
        HStack {

            TextField("Search ...", text: $text).onSubmit {
                onCommit?()
            }
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""

                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

