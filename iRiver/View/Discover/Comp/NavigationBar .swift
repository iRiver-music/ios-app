//
//  NavigationBar .swift
//  iRiver
//
//  Created by laihungwei on 2023/8/14.
//

import Foundation
import SwiftUI
import Kingfisher

struct NavigationBar : View {
    var username: String
    var user_img_url: String
    var title: String
    
    let url = URL(
           string: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfsasdisher-1.jpg?raw=true"
       )
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Spacer()
            }
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("探索")
                        .font(
                            Font.custom("SF Pro", size: 34)
                                .weight(.bold)
                        )
                        .foregroundColor(.white)
                    //                        推到右邊
                    Spacer()
                    // user
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 34, height: 34)
                        .background(
                            KFImage(url)
                                .placeholder {
                                    Image(systemName: "person.fill")
                                        .font(.largeTitle)
                                        .opacity(0.3)
                                }
                                .retry(maxCount: 3, interval: .seconds(5))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 34, height: 34)
                                .clipped()
                        )
                        .cornerRadius(34)
                }
                .padding(.horizontal, 16)
                .padding(.top, 3)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(.black.opacity(0.75))
            .overlay(
                Rectangle()
                    .inset(by: 0.17)
                    .stroke(.white.opacity(0.15), lineWidth: 0.33)
            )
        }
    }
}
