//
//  LoadingButton.swift
//  WatchFace
//
//  Created by MacBook on 06.01.2021.
//

import UIKit

class LoadingButton: UIButton {

    internal lazy var spinnerView: UIActivityIndicatorView = {
        
        let spinerView = UIActivityIndicatorView(frame: .zero)
        spinerView.style = .white
              
        addSubview(spinerView)

        spinerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(30.0)
        }
                
        return spinerView
    }()
    
    private var title: String?

    func load(_ val: Bool) {
        
        if val {
            title = titleLabel?.text
            setTitle("", for: .normal)
            
            spinnerView.startAnimating()
            isUserInteractionEnabled = false
            
        } else {
            spinnerView.stopAnimating()
            isUserInteractionEnabled = true

            setTitle(title, for: .normal)
        }
    }
}
