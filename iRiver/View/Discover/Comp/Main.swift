//
//  NavigationBar .swift
//  iRiver
//
//  Created by laihungwei on 2023/8/14.
//

import Foundation
import SwiftUI
import Kingfisher

struct DiscoverMainView : View {

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Title2/Regular
            Text("TOP 100")
                .font(.system(size: 22, weight: .regular)) // 使用預設字型
                .frame(maxWidth: .infinity, alignment: .leading) // 靠左對齊
                .padding(.leading, 15) // 添加左邊的填充寬度
                .foregroundColor(Constants.TypographyPrimary)


            
            DiscoverBannerScrollView()
            
            DiscoverMusicList()
        }
        .padding(0)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .overlay(
            Rectangle()
                .inset(by: 0.17)
                .stroke(.white.opacity(0.15), lineWidth: 0.33)
        )
    }
}

