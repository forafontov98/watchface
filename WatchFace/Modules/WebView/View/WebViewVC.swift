//
//  WebViewVC.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit

class WebViewVC: UIViewController {

    var mainView = WebView()
    
    private var presenter: IWebViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let request = presenter?.makeRequest() {
            mainView.webView.load(request)
        }
        
        setTargets()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func setTargets() {
        mainView.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
    }
    
    func setPresenter(_ presenter: IWebViewPresenter) {
        self.presenter = presenter
    }
    
    @objc
    func cancelBtnPressed() {
        presenter?.dismiss()
    }
}
