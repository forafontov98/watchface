//
//  WatchListBuilder.swift
//  WatchFace
//
//  Created by MacBook on 29.12.2020.
//

import UIKit

class WatchListBuilder: NSObject {
    
    func buildListRequest() -> HttpRequestData {
        return HttpRequestData(endpoint: "/apple_watch/photos.json", params: nil)
    }
    
}
