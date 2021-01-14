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
        return button
    }()
    
    private (set) var cancelIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "cancel_btn")
        icon.contentMode = .scaleAspectFit
        icon.heroID = "cancel_btn"
        return icon
    }()
    
    private (set) var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
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
        label.text = "To download the watch face, watch an ad or sign up for a subscription".localized
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private (set) var adBtn: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "baseGreen")
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        button.setTitle("Ad".localized, for: .normal)
        return button
    }()
    
    private (set) var subscriptionBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "baseOrange")
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        button.setTitle("Subscribe".localized, for: .normal)
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
        
        addSubview(cancelIcon)
        
        cancelIcon.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-16.0)
            $0.width.height.equalTo(20.0)
            $0.top.equalTo(self.snp.topMargin).offset(49.0)
        }
        
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.center.equalTo(cancelIcon.snp.center)
            $0.width.height.equalTo(50.0)
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
    
    var loadingState = false {
        didSet {
            if loadingState {
                adBtn.load(true)
                subscriptionBtn.alpha = 0.5
                cancelBtn.alpha = 0.5
                
                isUserInteractionEnabled = false
                
            } else {
                adBtn.load(false)
                subscriptionBtn.alpha = 1.0
                cancelBtn.alpha = 1.0
                
                isUserInteractionEnabled = true
            }
        }
    }
}

extension LockingScreenView {
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addSubscriptionBtnParget(target: Any?, action: Selector) {
        subscriptionBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addAdBtnTarget(target: Any?, action: Selector) {
        adBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
