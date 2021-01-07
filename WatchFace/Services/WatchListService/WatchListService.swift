//
//  WatchListService.swift
//  WatchFace
//
//  Created by MacBook on 29.12.2020.
//

import UIKit

protocol IWatchListService {
    func watchListRequest(callback: @escaping([WatchCategory]) -> Void)
}

class WatchListService: NSObject {
    
    private let client: IHttpClient = HttpClient()
    private let builder = WatchListBuilder()
    
    func watchListRequest(callback: @escaping([WatchCategory]) -> Void) {
        
        let req = builder.buildListRequest()
        
        client.getRequest(request: req) { (result) in
            switch result {
            case .success(let data):
                
                print(String(data: data, encoding: .utf8)!)

                do {
                    let response = try JSONDecoder().decode(WatchListResponse.self, from: data)
                    
                    callback(response.categories)
                    
                } catch {
                    print(error)
                    callback([])
                }
                
            case .failure(let error):
                print(error)
                callback([])

            }
        }
        
    }
    
}
