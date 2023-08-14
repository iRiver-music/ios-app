//
//  DiscoverMusicList.swift
//  iRiver
//
//  Created by laihungwei on 2023/8/14.
//

import SwiftUI

struct DiscoverMusicList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ScrollView(.vertical, showsIndicators: true) {
                // 在這裡添加清單內容
                ForEach(0..<20) { index in
                 DiscoverMusicCell()
                }
            }
            .frame(width: 361, height: 420 - 30, alignment: .top) // 減去標題的高度
        }
        .padding(0)
        .frame(width: 361, height: 420, alignment: .topLeading)
    }
}


struct DiscoverMusicCell: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
            
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 50, height: 50)
                    .background(
                        //MARK: Image
                        Image("style")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                    )
                    .cornerRadius(12)

                // Footnote/Regular
                //MARK: number
                HStack(alignment: .center, spacing: 12) {
                    Text("1")
                        .font(.system(size: 13 , weight: .regular))
                                  .foregroundColor(.white)
                }
                .padding(0)

                //MARK: Title--Group (Item--Song--iOS)
                
                VStack(alignment: .leading, spacing: 2) {
                    // Body/Regular
                    //MARK: title
                    Text("BREAK MY SOUL")
                        .font(.system(size: 13 , weight: .regular))
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    // Footnote/Regular
                    //MARK: artist
                    Text("Beyoncé (碧昂絲)")
//                      .font(Font.custom("SF Pro", size: 13))
                      .foregroundColor(Color(red: 0.92, green: 0.92, blue: 0.96).opacity(0.6))
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                
             // img title artist ....
            }
            .padding(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            //MARK: button group
            HStack(alignment: .center, spacing: 10) {
                //MARK: heart

                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "heart")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.97))

                }
                .padding(0)
//                .frame(width: 361, height: 66, alignment: .center)

                //MARK: add
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "plus")
//                        .font(Font.custom("SF Pro", size: 17))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.97))


                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(width: 50, height: 50, alignment: .center)
//
            }
            .padding(0)
            .frame(maxHeight: .infinity, alignment: .leading)
            
          


         // cell
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 8)
        .frame(width: 361, alignment: .leading)
    }
    
}

struct DiscoverMusicList_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverMusicList()
    }
}
