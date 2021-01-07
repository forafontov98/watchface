//
//  WebViewBuilder.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit

class WebViewBuilder: NSObject {

    func build(url: String) -> WebViewVC {
        
        let vc = WebViewVC()
        
        let router = WebViewRouter(view: vc)
        let interactor = WebViewInteractor()
        let presenter = WebViewPresenter(view: vc, interactor: interactor, router: router)
        
        interactor.url = url
        
        vc.setPresenter(presenter)
        
        return vc
        
    }
    
}
