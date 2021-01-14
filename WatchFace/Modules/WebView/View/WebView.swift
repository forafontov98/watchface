//
//  WebView.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import WebKit

class WebView: UIView {

    private (set) var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private (set) var cancelBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel".localized, for: .normal)
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16.0)
            $0.top.equalTo(self.snp.topMargin).offset(16.0)
        }
        
        addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(cancelBtn.snp.bottom).offset(16.0)
        }
    }
}

extension WebView {
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
