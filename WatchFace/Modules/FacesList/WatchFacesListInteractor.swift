//
//  WatchFacesListInteractor.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

protocol IWatchFacesListInteractor {
    func watchListRequest(callback: @escaping([WatchCategory]) -> Void)
}

class WatchFacesListInteractor: NSObject, IWatchFacesListInteractor {

    override init() {
        super.init()
    }
    
    func watchListRequest(callback: @escaping([WatchCategory]) -> Void) {
        let service = WatchListService()
        service.watchListRequest(callback: callback)
    }
    
}
