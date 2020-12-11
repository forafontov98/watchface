//
//  WatchPreviewView.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit

class WatchPreviewView: UIView {

    private (set) var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Some group"
        label.textColor = UIColor(named: "darkTextColor")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private (set) var cancelBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel_btn"), for: .normal)
        button.heroID = "cancel_btn"
        return button
    }()
    
    private (set) var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        let view = UIVisualEffectView(effect: effect)
        return view
    }()
    
    private (set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private (set) var downloadBtn: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor(named: "baseGreen")
        button.setTitle("Скачать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        return button
    }()
    
    private (set) var questionBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "question"), for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        //backgroundColor = UIColor.white.withAlphaComponent(0.85)
        backgroundColor = .clear
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        addSubview(blurView)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-16.0)
            $0.width.height.equalTo(20.0)
        }
        
        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16.0)
            $0.top.equalTo(self.snp.topMargin).offset(40.0)
            $0.right.equalTo(self.cancelBtn.snp.left).offset(-16.0)
            $0.height.equalTo(39.0)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.centerY.equalTo(self.topLabel)
        }
        
        addSubview(downloadBtn)
        
        downloadBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottomMargin).offset(-40.0)
            $0.left.equalToSuperview().offset(16.0)
            $0.height.equalTo(64.0)
        }
        
        addSubview(questionBtn)
        
        questionBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottomMargin).offset(-40.0)
            $0.right.equalToSuperview().offset(-16.0)
            $0.height.width.equalTo(64.0)
        }
        
        downloadBtn.snp.makeConstraints {
            $0.right.equalTo(self.questionBtn.snp.left).offset(-16.0)
        }
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(45.0)
            $0.right.equalToSuperview().offset(-45.0)
            $0.top.equalTo(self.topLabel.snp.bottom).offset(45.0)
            $0.bottom.equalTo(self.downloadBtn.snp.top).offset(-45.0)
        }
    }
}

extension WatchPreviewView {
    
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addDownloadBtnTarget(target: Any?, action: Selector) {
        downloadBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
