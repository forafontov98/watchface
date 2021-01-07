//
//  WebViewRouter.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit

protocol IWebViewRouter {
    func dismiss()
}

class WebViewRouter: NSObject, IWebViewRouter {

    private weak var view: WebViewVC?

    init(view: WebViewVC) {
        self.view = view
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}
