import Foundation

struct AlbumSupuerSet: Decodable, Identifiable {
    let id: Int
    let set: [AlbumSet]
    let title: String
}



struct AlbumSet: Decodable, Identifiable{
    let id: Int
    let album: AlbumModel
}


struct AlbumModel: Decodable,Identifiable {
    let id: Int
    let artist: String
    let desc: String
    let title: String
}

// artist

struct ArtistDetailModel: Decodable, Identifiable{
    let id: Int
    let artist: [ArtistModel]
    let songs: [SongModel]
}

struct ArtistModel: Decodable, Identifiable{
    let id: Int
    let artist: String
    let summary: String
}

struct SongModel: Decodable, Identifiable{
    let id: Int
    let artist: String
    let title: String
    let music_ID: String
    let album: String
    let label: String?
    let artist_url: String
    let sources: String
    let download_status: Bool
    let style: String?
    let country: String?
    let language: String?
    let description: String?
    let keywords: String?
    let ch_lyrics: String
    let en_lyrics: String
    let rating: String?
    let views: Int
    let release_year: Int
    let publish_time: Int
}



public class CurrentMusicData: ObservableObject {
    @Published var artist: String = ""
    @Published var music_ID: String = ""
    @Published var musicTitle: String = ""
    @Published var songURL: String = ""
    @Published var Album: [SongModel] = []
    @Published var currentSong: SongModel? = nil
}

public class CurrentData: ObservableObject {
    @Published var searchText: String = ""
    @Published var isSongListViewActive: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var songURL: String = ""
}
