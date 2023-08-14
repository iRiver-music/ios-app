//
//  BannerScroll.swift
//  iRiver
//
//  Created by laihungwei on 2023/8/14.
//

import SwiftUI

struct DiscoverBannerScroll: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .center, spacing: 10) {
                //            text
                VStack(alignment: .leading, spacing: 4) {
                    
                    // Subheadline/Regular
                    Text("電子舞曲")
                        .font(Font.custom("SF Pro", size: 15))
                        .foregroundColor(Constants.TypographyPrimary)
                    HStack(alignment: .center, spacing: 4) {
                        //                    iocn
                        Image(systemName: "music.note")
                        
                            .multilineTextAlignment(.center)
                            .foregroundColor(Constants.TypographySecondary)
                            .frame(width: 16, alignment: .center)
                        //                        text
                        VStack(alignment: .leading, spacing: 16) {
                            // Footnote/Regular
                            Text("Around the World-Daft Punk")
                                .font(Font.custom("SF Pro", size: 13))
                                .foregroundColor(Constants.TypographySecondary)
                                .frame(width: 99, alignment: .leading)
                        }
                        .padding(0)
                    }
                    .padding(0)
                    .frame(width: 118, alignment: .leading)
                    
                    
                   
                }
                .padding(0) }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color(red: 0.47, green: 0.37, blue: 0.75).opacity(0.2))
            .cornerRadius(Constants.SurfaceCardRadiusSM)
        }.padding(0)
    }
}


struct BannerScroll_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverBannerScroll()
    }
}
