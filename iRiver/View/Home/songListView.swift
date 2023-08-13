//
//  SongListView.swift
//  iRiver-music-test
//
//  Created by laihungwei on 2023/7/20.
//

import SwiftUI
import Kingfisher

struct SongListView: View {
    @EnvironmentObject var currentData: CurrentData
    @EnvironmentObject var musicData: CurrentMusicData
    @State var songs: [SongModel] = []
    @State var isLoad = false
    var album: AlbumModel
    
    @State private var isShowingSongDetail: Bool = false // State to control whether to show SongDetailView
    @State private var selectedSong: SongModel? // State to store the selected SongModel
    
    var body: some View {
        HStack { // Use ZStack to stack SongListView on top of the HomeView
            List {
                if isLoad{
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
            }
            .onAppear {
                DispatchQueue.global().async {
                    let apiManager = APIManager()
                    let url = makeSafeURL(from: "http://49.213.238.75:5001/api/music/songs/\(album.artist)")!

                    apiManager.fetch(url: url) { (result: Result<[SongModel], APIError>) in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                songs = data
                                isLoad = true
                            }
                        case .failure(let error):
                            print("API error:", error)
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the default button style
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width > 120 {
                            currentData.isSongListViewActive = false
                        }
                    }
            )
            .offset(x: currentData.isSongListViewActive ? 0 : UIScreen.main.bounds.width) // Use offset to move SongListView off-screen when isSongListViewActive is false
            .sheet(isPresented: $isShowingSongDetail, onDismiss: {
                // Code to run when SongDetailView is dismissed
                selectedSong = nil // Clear selectedSong when SongDetailView is dismissed
            }) {
                if let selectedSong = selectedSong {
                    SongDetailView()
                        .environmentObject(musicData)
                }
            }
        }
    }
}

