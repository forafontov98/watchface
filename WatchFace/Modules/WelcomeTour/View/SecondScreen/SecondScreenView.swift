//
//  SecondScreenView.swift
//  WatchFace
//
//  Created by MacBook on 12.12.2020.
//

import UIKit

class SecondScreenView: UIView {

    private (set) var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private (set) var leftWatchFace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "watch_1")
        return imageView
    }()
    
    private (set) var centerWatchFace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "watch_2")
        return imageView
    }()
    
    private (set) var rightWatchFace: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "watch_3")
        return imageView
    }()
    
    private (set) var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.text = "Задай индивидуальный стиль"
        label.textColor = UIColor(named: "darkTextColor")
        return label
    }()
    
    private (set) var centerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.text = "Разнообразные"
        label.textColor = UIColor(named: "darkTextColor")
        return label
    }()
    
    private (set) var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.text = "Подбери циферблат соотвествующий твоему настроению или образу жизни"
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    private (set) var nextBtn: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor(named: "baseGreen")
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private (set) var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = UIColor(named: "baseGreen")
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.2)
                
        return pageControl
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
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        
        containerView.addSubview(leftWatchFace)
        
        leftWatchFace.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(213.0)
            $0.width.equalTo(176.0)
            $0.right.equalTo(self.containerView.snp.left).offset(42.0)
        }
        
        containerView.addSubview(rightWatchFace)
        
        rightWatchFace.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(213.0)
            $0.width.equalTo(176.0)
            $0.left.equalTo(self.containerView.snp.right).offset(-42.0)
        }
        
        containerView.addSubview(centerWatchFace)
        
        centerWatchFace.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(280.0)
            $0.left.equalTo(self.leftWatchFace.snp.right).offset(20.0)
            $0.right.equalTo(self.rightWatchFace.snp.left).offset(-20.0)
        }
        
        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.bottom.equalTo(self.containerView.snp.bottom).offset(-10.0)
        }
        
        addSubview(centerLabel)
        
        centerLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(self.topLabel.snp.bottom).offset(2.0)
        }
        
        addSubview(bottomLabel)
        
        bottomLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(self.centerLabel.snp.bottom).offset(12.0)
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
        }
    }
    
}

extension SecondScreenView {
    
    func addNextBtnTarget(target: Any?, action: Selector) {
        nextBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
