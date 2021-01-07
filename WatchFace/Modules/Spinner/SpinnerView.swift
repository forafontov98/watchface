//
//  SpinnerView.swift
//  WatchFace
//
//  Created by MacBook on 06.01.2021.
//

import UIKit

class SpinnerView: UIView {
    
    private (set) var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.layer.cornerRadius = 16.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private (set) var spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .white)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        addSubview(blurView)
        
        blurView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(60.0)
        }
        
        addSubview(spinner)
        
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
