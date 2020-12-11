//
//  WatchPreviewBuilder.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit

class WatchPreviewBuilder: NSObject {

    func build(image: UIImage?) -> UIViewController {
        let vc = WatchPreviewVC()
        
        let router = WatchPreviewRouter(view: vc)
        let interactor = WatchPreviewInteractor()
        let presenter = WatchPreviewPresenter(view: vc, router: router, interactor: interactor)
        
        vc.setPresenter(presenter)
        vc.setWatchFace(image)
        
        return vc
    }
    
}
