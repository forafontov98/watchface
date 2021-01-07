//
//  WebViewInteractor.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit
import WebKit

protocol IWebViewInteractor {
    func makeRequest() -> URLRequest?
}

class WebViewInteractor: NSObject, IWebViewInteractor {
    
    var url: String?

    func makeRequest() -> URLRequest? {
        guard let urlStr = url, let url = URL(string: urlStr) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        return request
    }
    
}
