//
//  WatchFaceCVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SkeletonView

class WatchFaceCVC: UICollectionViewCell {
    
    private (set) var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16.7

        return imageView
    }()
    
    private (set) var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 6.0, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    private (set) var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let lockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mdi_lock")
        return imageView
    }()
    
    var watch: WatchFace? {
        didSet {
            guard let watch = watch else { return }
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
        
        //isSkeletonable = true
        //previewImageView.isSkeletonable = true

    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
    }
    
    func makeConstraints() {
        contentView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        previewImageView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.right.equalToSuperview().offset(-10.0)
        }
        
        previewImageView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(-3)
            $0.right.equalToSuperview().offset(-10.0)
        }
        
        contentView.addSubview(lockIcon)
        
        lockIcon.snp.makeConstraints {
            $0.left.equalTo(previewImageView.snp.left).offset(26.0)
            $0.right.equalTo(previewImageView.snp.right).offset(-26.0)
            $0.bottom.equalTo(previewImageView.snp.bottom).offset(-26.0)
            $0.height.equalTo(lockIcon.snp.width)
        }
    }
}

extension WatchFaceCVC {
    
    private func dateAndTimeConfig() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd"
        
        dateLabel.text = dateFormatter.string(from: Date()).uppercased()
        
        dateFormatter.dateFormat = "HH:mm"
        
        timeLabel.text = dateFormatter.string(from: Date())
    }
}
