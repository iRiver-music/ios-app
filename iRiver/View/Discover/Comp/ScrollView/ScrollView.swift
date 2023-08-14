import SwiftUI

struct DiscoverBannerScrollView: View {

    var body: some View {
        ZStack {
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { _ in
                            DiscoverCard()
                        }
                        
                    }
                    .padding()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { _ in
                            DiscoverLableScrollView()
                        }
                        
                    }
                    .padding()
                }
            }
        }
    }
}




struct HorizontalCardScrollViewWithVStack_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverBannerScrollView()
    }
}
