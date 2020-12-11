//
//  LockingScreenView.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class LockingScreenView: UIView {

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
    
    private (set) var grayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 26.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "lightGray")
        return view
    }()
    
    private (set) var lockingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mdi_lock")
        return imageView
    }()
    
    private (set) var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.textColor = .gray
        label.text = "Чтобы скачать циферблат посмотри рекламу или оформи подписку"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private (set) var adBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "baseGreen")
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        button.setTitle("AD", for: .normal)
        return button
    }()
    
    private (set) var subscriptionBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "baseOrange")
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        button.setTitle("Subscription", for: .normal)
        return button
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
            $0.edges.equalToSuperview()
        }
        
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-16.0)
            $0.width.height.equalTo(20.0)
            $0.top.equalTo(self.snp.topMargin).offset(49.0)
        }
        
        addSubview(grayView)
        
        grayView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30.0)
            $0.right.equalToSuperview().offset(-30.0)
            $0.centerY.equalToSuperview()
        }
        
        grayView.addSubview(lockingImageView)
        
        lockingImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(90.0)
        }
        
        grayView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30.0)
            $0.right.equalToSuperview().offset(-30.0)
            $0.top.equalTo(self.lockingImageView.snp.bottom).offset(30.0)
        }
        
        grayView.addSubview(adBtn)
        
        adBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(39.0)
            $0.height.equalTo(50.0)
        }
        
        grayView.addSubview(subscriptionBtn)
        
        subscriptionBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(self.adBtn.snp.bottom).offset(15.0)
            $0.height.equalTo(50.0)
            $0.bottom.equalToSuperview().offset(-25.0)
        }
    }
    
}

extension LockingScreenView {
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
