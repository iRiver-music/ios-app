import SwiftUI
//
//struct ImageView: View {
//    let imageURL: URL?
//
//    var body: some View {
//        Group {
//            if let url = imageURL, let imageData = try? Data(contentsOf: url),
//               let uiImage = UIImage(data: imageData) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            } else {
//
//                Image(systemName: "photo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}

func makeSafeURL(from urlString: String) -> URL? {
    guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
        return nil
    }
    return URL(string: encodedString)
}
