//
//  FirstScreenView.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class FirstScreenView: UIView {

    private (set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .bottom
        imageView.image = UIImage(named: "wt_bg1")
        return imageView
    }()
    
    private (set) var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.text = "Для Aplle Watch"
        label.textColor = UIColor(named: "darkTextColor")
        return label
    }()
    
    private (set) var centerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.text = "Циферблаты"
        label.textColor = UIColor(named: "darkTextColor")
        return label
    }()
    
    private (set) var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.text = "Выбирай из большой и уникальной библиотеки великолепных циферблатов"
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    private (set) var nextBtn: UIButton = {
        let button = UIButton(type: .system)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor(named: "baseBlue")
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .semibold)
        return button
    }()
    
    private (set) var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(named: "baseBlue")
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
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        
        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.bottom.equalTo(self.imageView.snp.bottom).offset(-10.0)
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

extension FirstScreenView {
    
    func addNextBtnTarget(target: Any?, action: Selector) {
        nextBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
