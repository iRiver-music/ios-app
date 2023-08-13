//
//  userBarView.swift
//  iRiver-music-test
//
//  Created by laihungwei on 2023/7/15.
//

import SwiftUI

struct userBarView: View {
    var body: some View {
        ZStack() { // 将 alignment 设置为 .topTrailing
  
            
            Button(action: {
                // 用户按钮的操作
            }) {
                Image(systemName: "person.circle")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .padding()
            }
        }
    }
}


//struct userBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        userBarView()
//    }
//}
