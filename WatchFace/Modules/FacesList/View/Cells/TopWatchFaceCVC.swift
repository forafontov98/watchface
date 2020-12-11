//
//  TopCVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

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
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "Apple Watch 44mm")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Apple Watch 44mm"
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        makeConstraints()
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
        previewImageView.image = UIImage(named: "Apple Watch 44mm")
    }
    
    func makeConstraints() {
        addSubview(bgView)
        
        bgView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.snp.top)
            $0.height.equalTo(232.0)
            $0.width.equalTo(176.0)
        }
        
        addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints {
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
            $0.height.equalTo(190.0)
            $0.width.equalTo(157.0)
        }
        
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.bgView.snp.top).offset(11.0)
            $0.left.equalTo(self.bgView.snp.left).offset(16.0)
            $0.right.equalTo(self.bgView.snp.right).offset(16.0)
        }
    }
    
}
