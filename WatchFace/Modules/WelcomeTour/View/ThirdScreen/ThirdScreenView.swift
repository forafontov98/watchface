//
//  ThirdScreenView.swift
//  WatchFace
//
//  Created by MacBook on 12.12.2020.
//

import UIKit

class ThirdScreenView: UIView {

    private (set) var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private (set) var leftWatchFace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "watch_4")
        return imageView
    }()
    
    private (set) var centerWatchFace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "watch_5")
        return imageView
    }()
    
    private (set) var rightWatchFace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "watch_6")
        return imageView
    }()
    
    private (set) var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 31.0, weight: .bold)
        label.text = "Premium subscription".localized
        label.textColor = UIColor(named: "darkTextColor")
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private (set) var firstOrangeCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "baseOrange")
        return view
    }()
    
    private (set) var secondOrangeCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(named: "baseOrange")
        return view
    }()
    
    private (set) var firstSubscriptionLineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.text = "Access to all clock faces".localized
        label.textColor = UIColor(named: "darkTextColor")
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private (set) var secondSubscriptionLineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.text = "No ad".localized
        label.textColor = UIColor(named: "darkTextColor")
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private (set) var nextBtn: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor(named: "baseOrange")
        button.setTitle("Subscribe".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private (set) var monthSubscriptionBtn: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Month subscription".localized + " ___,__ " + "per month".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private (set) var weekSubscriptionBtn: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor(named: "darkBlue")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Week subscription".localized + " ___,__ " + "per week".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private (set) var cancelBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel_btn_2"), for: .normal)
        return button
    }()
    
    private (set) var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 2
        pageControl.currentPageIndicatorTintColor = UIColor(named: "baseOrange")
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.2)
        return pageControl
    }()
    
    private (set) var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.text = "Start your 3 days free trial".localized + ". " + "The plan renews automaticaly".localized + ". " + "Cancel any time".localized
        label.textColor = UIColor(named: "darkTextColor")
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private (set) var privacyBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .regular)
        button.setTitle("Privacy policy".localized, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private (set) var termsBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .regular)
        button.setTitle("Terms".localized, for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private (set) var restoreBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .regular)
        button.setTitle("Restore purchases".localized, for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    init(weekPrice: String?, monthPrice: String?) {
        super.init(frame: .zero)

        setWeekPrice(weekPrice)
        setMonthPrice(monthPrice)

        backgroundColor = .white
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.41)
        }
        
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.top.equalTo(self.snp.topMargin).offset(12.0)
            $0.height.width.equalTo(24.0)
        }
        
        addSubview(restoreBtn)
        
        restoreBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(self.snp.topMargin).offset(12.0)
        }
        
        containerView.addSubview(centerWatchFace)
        
        centerWatchFace.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.containerView.snp.top).offset(49.0)
            $0.bottom.equalTo(self.containerView.snp.bottom).offset(-45.0)
            $0.width.equalTo(centerWatchFace.snp.height).multipliedBy(0.56)
        }
        
        containerView.addSubview(leftWatchFace)
        
        leftWatchFace.snp.makeConstraints {
            $0.centerY.equalTo(self.centerWatchFace)
            $0.height.equalTo(self.centerWatchFace.snp.height)
            $0.width.equalTo(self.centerWatchFace.snp.width)
            $0.right.equalTo(self.centerWatchFace.snp.left).offset(-30.0)
        }
        
        containerView.addSubview(rightWatchFace)
        
        rightWatchFace.snp.makeConstraints {
            $0.centerY.equalTo(self.centerWatchFace)
            $0.height.equalTo(self.centerWatchFace.snp.height)
            $0.width.equalTo(self.centerWatchFace.snp.width)
            $0.left.equalTo(self.centerWatchFace.snp.right).offset(30.0)
        }
        
        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(self.containerView.snp.bottom).offset(15.0)
        }
        
        addSubview(firstOrangeCircle)
        
        firstOrangeCircle.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.height.width.equalTo(8.0)
        }
        
        addSubview(firstSubscriptionLineLabel)
        
        firstSubscriptionLineLabel.snp.makeConstraints {
            $0.top.equalTo(self.topLabel.snp.bottom).offset(10.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.left.equalTo(self.firstOrangeCircle.snp.right).offset(11.0)
        }
        
        firstOrangeCircle.snp.makeConstraints {
            $0.centerY.equalTo(self.firstSubscriptionLineLabel)
        }
        
        addSubview(secondOrangeCircle)
        
        secondOrangeCircle.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.height.width.equalTo(8.0)
        }
        
        addSubview(secondSubscriptionLineLabel)
        
        secondSubscriptionLineLabel.snp.makeConstraints {
            $0.top.equalTo(self.firstSubscriptionLineLabel.snp.bottom).offset(10.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.left.equalTo(self.secondOrangeCircle.snp.right).offset(11.0)
        }
        
        secondOrangeCircle.snp.makeConstraints {
            $0.centerY.equalTo(self.secondSubscriptionLineLabel)
        }
        
        addSubview(monthSubscriptionBtn)
        
        monthSubscriptionBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(self.snp.height).multipliedBy(0.089)
            $0.top.equalTo(secondSubscriptionLineLabel.snp.bottom).offset(16.0)
        }
        
        addSubview(weekSubscriptionBtn)
        
        weekSubscriptionBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(self.snp.height).multipliedBy(0.089)
            $0.top.equalTo(monthSubscriptionBtn.snp.bottom).offset(6.0)
        }
        
        addSubview(pageControl)
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottomMargin).offset(-8.0)
            $0.height.equalTo(10.0)
        }
        
        addSubview(nextBtn)
        
        nextBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.height.equalTo(self.snp.height).multipliedBy(0.089)
            $0.bottom.equalTo(self.pageControl.snp.top).offset(-16.0)
            $0.height.lessThanOrEqualTo(64.0)
        }
        
        addSubview(subscriptionLabel)
        
        subscriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(nextBtn.snp.top).offset(-10.0)
        }
        
        addSubview(privacyBtn)
        
        privacyBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottomMargin).offset(-5.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalTo(self.snp.centerX).offset(-25.0)
        }
        
        addSubview(termsBtn)
        
        termsBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottomMargin).offset(-5.0)
            $0.left.equalTo(self.snp.centerX).offset(25.0)
            $0.right.equalToSuperview().offset(-20.0)
        }
    }
    
}

extension ThirdScreenView {
    
    func addNextBtnTarget(target: Any?, action: Selector) {
        nextBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addPrivacyPolicyTarget(target: Any?, action: Selector) {
        privacyBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addTermsTarget(target: Any?, action: Selector) {
        termsBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addRestoreTarget(target: Any?, action: Selector) {
        restoreBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addWeekSubscriptionTarget(target: Any?, action: Selector) {
        weekSubscriptionBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addMonthSubscriptionTarget(target: Any?, action: Selector) {
        monthSubscriptionBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension ThirdScreenView {
    func setWeekPrice(_ str: String?) {
        
        if let str = str {
            weekSubscriptionBtn.setTitle("Week subscription".localized +
                                            " " + str + " " +
                                            "per week".localized, for: .normal)
        } else {
            weekSubscriptionBtn.setTitle("Week subscription".localized, for: .normal)
        }

    }
    
    func setMonthPrice(_ str: String?) {
        if let str = str {
            monthSubscriptionBtn.setTitle("Month subscription".localized +
                                            " " + str + " " +
                                            "per month".localized, for: .normal)
        } else {
            monthSubscriptionBtn.setTitle("Month subscription".localized, for: .normal)
        }
    }
    
    func weekSelected() {
        weekSubscriptionBtn.backgroundColor = UIColor(named: "darkBlue")
        weekSubscriptionBtn.setTitleColor(.white, for: .normal)
        
        monthSubscriptionBtn.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        monthSubscriptionBtn.setTitleColor(.black, for: .normal)
    }
    
    func monthSelected() {
        monthSubscriptionBtn.backgroundColor = UIColor(named: "darkBlue")
        monthSubscriptionBtn.setTitleColor(.white, for: .normal)
        
        weekSubscriptionBtn.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        weekSubscriptionBtn.setTitleColor(.black, for: .normal)
    }
}
