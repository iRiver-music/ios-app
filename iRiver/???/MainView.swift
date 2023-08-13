import SwiftUI


struct MainView: View {
    @EnvironmentObject var currentData: CurrentData
    @EnvironmentObject var musicData: CurrentMusicData
    
    @State private var isExpanded = false

       
    var body: some View {
        ZStack(alignment: .bottom) {
            // 视图内容
            TabView(selection: $currentData.selectedIndex) {
                HomeView()
                    .environmentObject(currentData)
                    .environmentObject(musicData)
                    .tabItem {
                        Label("home", systemImage: "house")
                    }
                    .tag(0)
                
                SearchView()
                    .environmentObject(currentData)
                    .environmentObject(musicData)
                    .tabItem {
                        Label("search", systemImage: "magnifyingglass")
                    }
                    .tag(1)
                

                Lib()
                    .environmentObject(musicData)
                    .tabItem {
                        Label("lib", systemImage: "person")
                    }
                    .tag(2)
            }
            .tabViewStyle(DefaultTabViewStyle())
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            
        
            ZStack(alignment: .topTrailing) {
                Color.clear
                userBarView()
                    .environmentObject(currentData)
            }
            
            VStack {
                MusicPlayerView(isShow: true, isExpanded: $isExpanded)
                    .environmentObject(musicData)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CurrentMusicData())
            .environmentObject(CurrentData())

    }
}
