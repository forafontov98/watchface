//
//  WatchFacesTopView.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SnapKit

class WatchFacesTopView: UIView {

    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Циферблаты"
        label.textColor = UIColor(named: "darkTextColor")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let categoriesButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "categories_icon"), for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    private (set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 194.0, height: 240.0)
        layout.minimumLineSpacing = 16.0
        layout.sectionInset.left = 16.0
        layout.sectionInset.right = 16.0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(TopWatchFaceCVC.self, forCellWithReuseIdentifier: TopWatchFaceCVC.className)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func makeConstraints() {
        addSubview(categoriesButton)
        
        categoriesButton.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-16.0)
            $0.top.equalTo(self.snp.top).offset(26.0)
            $0.width.height.equalTo(30.0)
        }
        
        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16.0)
            $0.right.equalTo(self.categoriesButton.snp.left).offset(10.0)
            $0.top.equalTo(self.snp.top).offset(26.0)
        }
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.topLabel.snp.bottom).offset(16.0)
            $0.height.equalTo(240.0)
        }
    }
}
