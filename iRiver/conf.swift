//
//  conf.swift
//  iRiver
//
//  Created by laihungwei on 2023/8/13.
//

import Foundation
import SwiftUI


struct PortConfig {
    static let http = "http"
//    static let ip = "localhost"
    static let ip = "localhost"
    static let port = 5000
    static let errorCode = 404
    static let okCode = 200
    
    // Define other API configurations
    static let apiUrl = "\(http)://\(ip):\(port)/api"
    
    // music
    static func discoverUrl(for uid: String) -> String {
          return "\(apiUrl)/discover/\(uid)"
      }
    
//    user
    static let test_user = "123"
    
}




//color

struct Constants {
    static let SurfaceCardRadiusMD: CGFloat = 32
    static let SurfaceCardRadiusSM: CGFloat = 16
    
    static let TypographyPrimary: Color = Color(red: 0.98, green: 0.98, blue: 0.98)
    static let TypographySecondary: Color = Color(red: 0.98, green: 0.98, blue: 0.98).opacity(0.5)
    static let SurfaceIconFill: Color = Color(red: 0.98, green: 0.98, blue: 0.98)
    
    
    static let SurfaceLabelFill: Color = Color(red: 0.96, green: 0.96, blue: 0.96).opacity(0.2)

}


