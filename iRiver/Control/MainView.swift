import SwiftUI


struct MainView: View {
    @EnvironmentObject var currentData: CurrentData
    @EnvironmentObject var musicData: CurrentMusicData
    
    @State private var isExpanded = false

       
    var body: some View {
        ZStack(alignment: .bottom) {
            // 视图内容
            TabView(selection: $currentData.selectedIndex) {
                DiscoverVIew()
                    .environmentObject(currentData)
                    .environmentObject(musicData)
                    .tabItem {
                        Label("探索", systemImage: "house")
                    }
                    .tag(0)
                
                Text("sds")
                    .tabItem {
                        Label("播放列表", systemImage: "music.note")
                    }
                    .tag(1)
                
                Shuffle() // 添加你的自定義 Shuffle View
                       .tabItem {
                           Label("隨機播放", systemImage: "shuffle") // 使用 Label
                       }
                   
                Lib()
                    .environmentObject(musicData)
                    .tabItem {
                        Label("資料庫", systemImage: "person")
                    }
                    .tag(3)
                
                
                
                SearchView()
                    .environmentObject(currentData)
                    .environmentObject(musicData)
                    .tabItem {
                        Label("search", systemImage: "magnifyingglass")
                    }
                    .tag(4)
            }
            .tabViewStyle(DefaultTabViewStyle())
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            
        
//            ZStack(alignment: .topTrailing) {
//                Color.clear
//                userBarView()
//                    .environmentObject(currentData)
//            }
//
            VStack {
                MusicPlayerView(isShow: true, isExpanded: $isExpanded)
                    .environmentObject(musicData)
            }
        }
    }
}


struct Shuffle : View {
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 16) {
                
            }
            .padding(0)
            .background(Constants.SurfaceIconFill)
            .cornerRadius(100)
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "shuffle")
                   .font(Font.custom("SF Pro", size: 15))
                   .multilineTextAlignment(.center)
                   .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
            }
            .padding(.horizontal, 15)
            .padding(.top, 17)
            .padding(.bottom, 16)
            .frame(width: 58, height: 58, alignment: .center)
            
            
        }
        .frame(width: 393, height: 83)
        .background(.black.opacity(0.75))
        .shadow(color: .white.opacity(0.15), radius: 0, x: 0, y: -0.33)
      
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CurrentMusicData())
            .environmentObject(CurrentData())

    }
}
