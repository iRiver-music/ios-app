//
//  DiscoverCard.swift
//  iRiver
//
//  Created by laihungwei on 2023/8/14.
//

import SwiftUI
struct DiscoverCard: View {
    var body: some View {
          ZStack {
              Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 302, height: 168)
                  .background(
                      Image("style") // 將 "style" 替換為你的圖片名稱或 URL
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 302, height: 168)
                          .clipped()
                  )
                  .background(Color.white)
                  .cornerRadius(Constants.SurfaceCardRadiusMD)


              DiscoverBannerScroll()
          }
          .frame(width: 302, height: 168)
      }
}

struct DiscoverBannerScroll: View {
    
    var body: some View {
        VStack(alignment: .leading , spacing : 16) {
//            填充
            Spacer()
            
            HStack(alignment: .center, spacing: 10) {
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        // Subheadline/Regular
                        Text("電子舞曲")
                            .font(Font.custom("SF Pro", size: 15))
                            .foregroundColor(Constants.TypographyPrimary)
                        HStack(alignment: .center, spacing: 4) {
                            
                            //                    iocn
                            Image(systemName: "music.note")
                                .font(Font.custom("Font Awesome 6 Free", size: 16))
                                .foregroundColor(Constants.TypographySecondary)
                                .frame(width: 12, height: 12)
                            //                        text
                            VStack(alignment: .leading, spacing: 16) {
                                // Footnote/Regular
                                Text("Around the World-Daft Punk")
                                    .font(Font.custom("SF Pro", size: 13))
                                    .foregroundColor(Constants.TypographySecondary)
                                    .frame(width: 99, alignment: .leading)
                                    .lineLimit(1) // 設定最大行數為 1，多餘的文字使用 "..." 代替
                            }
                            .padding(0)
                        }
                        .padding(0)
                        .frame(width: 90, alignment: .leading)
                        
                        
                    }
                    .padding(0)
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color(red: 0.47, green: 0.37, blue: 0.75).opacity(0.2))
                .cornerRadius(Constants.SurfaceCardRadiusSM)
                
             
//                Button-Group (Bar--Control)
                HStack(alignment: .center, spacing: 14) {
//                    active
                    HStack(alignment: .center, spacing: 16) {
                        HStack(alignment: .center, spacing: 0) {
                            // Subheadline/Regular
                            Image(systemName: "play.fill")
                              .font(Font.custom("SF Pro", size: 15))
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                        }
                        .padding(.horizontal, 7)
                        .padding(.vertical, 4)
                        .frame(width: 28, height: 28, alignment: .center)
                    }
                    .padding(0)
                    .background(Constants.SurfaceIconFill)
                    .cornerRadius(100)
                    
//                   隨機播放
                    HStack(alignment: .center, spacing: 16) {
                        HStack(alignment: .center, spacing: 0) {
                            // Subheadline/Regular
                           Image(systemName: "shuffle")
                              .font(Font.custom("SF Pro", size: 15))
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                        }
                        .padding(.leading, 4)
                        .padding(.trailing, 3)
                        .padding(.vertical, 4)
                        .frame(width: 28, height: 28, alignment: .center)
                    }
                    .padding(0)
                    .background(Constants.SurfaceIconFill)
                    .cornerRadius(100)
                    
                }
                .padding(0)
                
                Spacer()
            }
            
            
        }
        .padding(16)
    }
}


struct DiscoverCard_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCard()
    }
}
