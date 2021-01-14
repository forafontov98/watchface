//
//  WatchPreviewInteractor.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit

protocol IWatchPreviewInteractor {
    var isPro: Bool { get }
    
    func loadAndSaveGif(watchFace: WatchFace, callback: @escaping(Gif2LiveStep) -> Void)
    
    func notShowAgain()
    func needToShowHelpAlert() -> Bool
}

class WatchPreviewInteractor: IWatchPreviewInteractor {
    var isPro: Bool {
        return SwiftyStoreService.shared.isPro
    }
    
    func loadAndSaveGif(watchFace: WatchFace, callback: @escaping(Gif2LiveStep) -> Void) {
        let service: IGif2LiveService = Gif2LiveService()
        
        service.start(watchFace: watchFace, callback: callback)
    }

    func notShowAgain() {
        UserDefaults.standard.setValue(true, forKey: Keys.not_show_again)
    }
    
    func needToShowHelpAlert() -> Bool {
        return !UserDefaults.standard.bool(forKey: Keys.not_show_again)
    }
}
