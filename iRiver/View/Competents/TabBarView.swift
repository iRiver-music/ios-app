//
//  TabBarView.swift
//  iRiver-music-test
//
//  Created by laihungwei on 2023/7/14.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("home", systemImage: "house")
                }
            
            Text("search")
                .tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}
