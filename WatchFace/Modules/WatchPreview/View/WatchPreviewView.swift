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
        label.textColor = UIColor(named: "darkTextColor")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
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
    
    private (set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.35)
        return imageView
    }()
    
    private (set) var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    private (set) var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 50.0, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private (set) var stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private (set) var lockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mdi_lock")
        return imageView
    }()
    
    private (set) var downloadBtn: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor(named: "baseGreen")
        button.setTitle("Download".localized, for: .normal)
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
        }
        
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.center.equalTo(cancelIcon.snp.center)
            $0.width.height.equalTo(50.0)
        }
        
        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16.0)
            $0.top.equalTo(self.snp.topMargin).offset(40.0)
            $0.right.equalTo(self.cancelIcon.snp.left).offset(-16.0)
            $0.height.equalTo(39.0)
        }
        
        cancelIcon.snp.makeConstraints {
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
        
        addSubview(stepLabel)
        
        stepLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(self.downloadBtn.snp.top).offset(-20.0)
        }
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(45.0)
            $0.right.equalToSuperview().offset(-45.0)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(self.imageView.snp.width).multipliedBy(1.21)
        }
        
        imageView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30.0)
            $0.right.equalToSuperview().offset(-26.0)
        }
        
        imageView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(-3)
            $0.right.equalToSuperview().offset(-26.0)
        }
        
        addSubview(lockIcon)
        
        lockIcon.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.left).offset(80.0)
            $0.right.equalTo(imageView.snp.right).offset(-80.0)
            $0.bottom.equalTo(imageView.snp.bottom).offset(-30.0)
            $0.height.equalTo(lockIcon.snp.width)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateImageViewCornerRadius()
    }
    
    private func updateImageViewCornerRadius() {
        imageView.layer.cornerRadius = imageView.frame.height * 0.152
    }
}

extension WatchPreviewView {
    
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addDownloadBtnTarget(target: Any?, action: Selector) {
        downloadBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addQuestionBtnTarget(target: Any?, action: Selector) {
        questionBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
}

extension WatchPreviewView {
    
    func dateAndTimeConfig() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd"
        
        dateLabel.text = dateFormatter.string(from: Date()).uppercased()
        
        dateFormatter.dateFormat = "HH:mm"
        
        timeLabel.text = dateFormatter.string(from: Date())
    }
}
