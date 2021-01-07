//
//  TopCVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SkeletonView

class TopWatchFaceCVC: UICollectionViewCell {
    
    private let bgView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20.0
        view.backgroundColor = UIColor(named: "baseBlue")
        return view
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private (set) var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    private (set) var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 27.0, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let lockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mdi_lock")
        imageView.isHidden = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    var watch: WatchFace? {
        didSet {
            guard let watch = watch else { return }
            
            nameLabel.text = "Apple Watch"
            previewImageView.loadImageWithKingFisher(for: watch.url)
            lockIcon.isHidden = watch.status == .free
            
            previewImageView.heroID = "watchFace_\(watch.url)"
            lockIcon.heroID = "lockIcon_\(watch.url)"
            
            dateAndTimeConfig()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        makeConstraints()
        
        isSkeletonable = true
        bgView.isSkeletonable = true
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
    }
    
    func makeConstraints() {
        contentView.addSubview(bgView)
        
        bgView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.snp.top)
            $0.height.equalTo(232.0)
            $0.width.equalTo(176.0)
        }
        
        contentView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints {
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
            $0.height.equalTo(190.0)
            $0.width.equalTo(157.0)
        }
        
        contentView.addSubview(lockIcon)
        
        lockIcon.snp.makeConstraints {
            $0.left.equalTo(previewImageView.snp.left).offset(26.0)
            $0.right.equalTo(previewImageView.snp.right).offset(-26.0)
            $0.bottom.equalTo(previewImageView.snp.bottom).offset(-26.0)
            $0.height.equalTo(lockIcon.snp.width)
        }
        
        previewImageView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.right.equalToSuperview().offset(-17.0)
        }
        
        previewImageView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(-3)
            $0.right.equalToSuperview().offset(-17.0)
        }
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.bgView.snp.top).offset(11.0)
            $0.left.equalTo(self.bgView.snp.left).offset(16.0)
            $0.right.equalTo(self.bgView.snp.right).offset(16.0)
        }
    }
}

extension TopWatchFaceCVC {
    
    private func dateAndTimeConfig() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd"
        
        dateLabel.text = dateFormatter.string(from: Date()).uppercased()
        
        dateFormatter.dateFormat = "HH:mm"
        
        timeLabel.text = dateFormatter.string(from: Date())
    }
}
