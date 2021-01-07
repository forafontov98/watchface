//
//  WebViewPresenter.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit

protocol IWebViewPresenter {
    func makeRequest() -> URLRequest?
    func dismiss()
}

class WebViewPresenter: NSObject, IWebViewPresenter {

    private weak var view: WebViewVC?
    private var interactor: IWebViewInteractor?
    private var router: IWebViewRouter?
        
    init(view: WebViewVC, interactor: IWebViewInteractor, router: IWebViewRouter) {
        super.init()
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func makeRequest() -> URLRequest? {
        return interactor?.makeRequest()
    }
    
    func dismiss() {
        router?.dismiss()
    }
}
