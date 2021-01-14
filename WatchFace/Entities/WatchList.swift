//
//  WatchList.swift
//  WatchFace
//
//  Created by MacBook on 29.12.2020.
//

import Foundation

class WatchListResponse: Codable {
    var categories: [WatchCategory]
}


class WatchCategory: Codable {
    var name: String
    var watches: [WatchFace]
}


class WatchFace: Codable {
    var url_mini: String
    var url_full: String
    var status: WFStatus
    
    func isGif() -> Bool {
        return url_mini.contains("gif")
    }
}


enum WFStatus: String, Codable {
    case free
    case paid
}
