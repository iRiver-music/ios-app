import SwiftUI
import Kingfisher


struct DiscoverVIew: View {
    //    test user
    @StateObject private var user = User()
    
    @EnvironmentObject var currentData: CurrentData
    @EnvironmentObject var musicData: CurrentMusicData
    @State private var albumSupuerSet: [AlbumSupuerSet] = []
    @State private var selectedAlbumSet: AlbumSet?
    @State private var isMusicPlayerVisible = false
    
    var body: some View {
        //        Mockup/主頁
        ZStack{
            VStack{
                NavigationBar(username: user.username , user_img_url: user.user_img_url , title: "探索")
                
                DiscoverMainView()
                
                Spacer()
            }
        }
//        .frame(width: .infinity, height: .infinity)
//       .background(.black)
    }
}

