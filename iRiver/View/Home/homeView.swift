import SwiftUI
import Kingfisher


struct HomeView: View {
    @EnvironmentObject var currentData: CurrentData
    @EnvironmentObject var musicData: CurrentMusicData
    @State private var albumSupuerSet: [AlbumSupuerSet] = []
    @State private var selectedAlbumSet: AlbumSet?
    @State private var isMusicPlayerVisible = false

    var body: some View {
        ZStack {
            if selectedAlbumSet == nil {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(albumSupuerSet, id: \.id) { albumSupuerSet in
                            VStack(alignment: .leading) {
                                Text(albumSupuerSet.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)

                                ScrollView(.horizontal) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(albumSupuerSet.set, id: \.id) { albumSet in
                                            Button(action: {
                                                withAnimation(.easeInOut(duration: 0.25)) {
                                                    selectedAlbumSet = albumSet
                                                    currentData.isSongListViewActive = true
                                                }
                                            }) {
                                                AlbumView(album: albumSet.album)
                                            }
                                        }
                                    }
                                }
//                                .animation(.easeInOut) // Apply animation to the entire ForEach

                            }
                        }
                    }
                }
                .padding(16)
                .transition(.slide) // Apply slide transition
                .animation(.default) // Set animation duration and curve
            } else {
                if currentData.isSongListViewActive{
                    SongListView(album: selectedAlbumSet!.album)
                        .environmentObject(musicData)
                        .environmentObject(currentData)
                        .onDisappear {
                            selectedAlbumSet = nil
                        }
                        .transition(.slide) // Apply slide transition
                        .animation(.default) // Set animation duration and curve
                }
            }
        }
        .onAppear {
            DispatchQueue.global().async {
                let apiManager = APIManager()
                let url = URL(string: "http://49.213.238.75:5001/api/discover/")!

                apiManager.fetch(url: url) { (result: Result<[AlbumSupuerSet], APIError>) in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            albumSupuerSet = data
                        }
                    case .failure(let error):
                        print("API error:", error)
                    }
                }
            }
        }
        .onReceive(currentData.$selectedIndex) { newSelectedIndex in
            if newSelectedIndex == 0 {
                currentData.isSongListViewActive = false
            }
        }
    }
}

