//
//  TestControl.swift
//  iRiver
//
//  Created by 蔡尚儒 on 2023/8/13.
//

import Foundation
import SwiftUI

struct TestControl: View {
    @State private var showSecondView = false

    var body: some View {
        VStack {
            if showSecondView {
                MainControl()
            } else {
                MainView()
                    .environmentObject(CurrentMusicData())
                    .environmentObject(CurrentData())
            }

            Button(action: {
                self.showSecondView.toggle()
            }) {
                Text("Toggle View")
            }
        }
    }
}
