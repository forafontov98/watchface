//
//  WatchPreviewBuilder.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit

class WatchPreviewBuilder: NSObject {

    func build(watch: WatchFace?, groupName: String?) -> UIViewController {
        let vc = WatchPreviewVC()
        
        let router = WatchPreviewRouter(view: vc)
        let interactor = WatchPreviewInteractor()
        let presenter = WatchPreviewPresenter(view: vc, router: router, interactor: interactor)
        
        presenter.watchFace = watch
        
        vc.setPresenter(presenter)
        vc.setGroupName(groupName)
        
        return vc
    }
    
}
