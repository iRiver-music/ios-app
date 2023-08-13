import SwiftUI
import Kingfisher

struct AlbumView: View {
    var album: AlbumModel
    
    var body: some View {
        VStack {
            KFImage(makeSafeURL(from: "http://49.213.238.75:8002/api/img/\(album.artist)/artist/"))
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(width: 120, height: 120)
                           .cornerRadius(8)
            
            Text(album.title)
                .font(.caption)
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.top, 4)
        }
        .onAppear(){
//            print("http://49.213.238.75:8002/api/img/\(album.artist)/artist/")
        }
        
    }
    
}
