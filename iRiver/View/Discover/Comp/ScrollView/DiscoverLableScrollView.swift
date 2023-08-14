//
//  DiscoverLableScrollView.swift
//  iRiver
//
//  Created by laihungwei on 2023/8/14.
//

import SwiftUI


struct DiscoverLableScrollView: View {
    @State private var isSelected = false // 追蹤是否被選中

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text("最近新增")
                .font(.system(size: isSelected ? 16 : 13, weight: isSelected ? .bold : .regular)) // 設定不同的字體
                .foregroundColor(Constants.TypographyPrimary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Constants.SurfaceLabelFill)
        .cornerRadius(Constants.SurfaceCardRadiusMD)
        .scaleEffect(isSelected ? 1.2 : 1.0) // 調整大小效果
        .onTapGesture {
            isSelected.toggle() // 切換選中狀態
        }
    }
}

struct DiscoverLableScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverLableScrollView()
    }
}
