//
//  WatchFaceCVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

class WatchFaceCVC: UICollectionViewCell {
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        imageView.image = UIImage(named: "Apple Watch 44mm")
        return imageView
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
        addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
