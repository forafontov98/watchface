//
//  FacesGroupView.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class FacesGroupView: UIView {

    private (set) var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Some group"
        label.textColor = UIColor(named: "darkTextColor")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private (set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset.left = 16.0
        layout.sectionInset.right = 16.0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(WatchFaceCVC.self, forCellWithReuseIdentifier: WatchFaceCVC.className)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        return cv
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

        addSubview(topLabel)
        
        topLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16.0)
            $0.top.equalTo(self.snp.topMargin)
            $0.right.equalTo(self.snp.right).offset(-16.0)
        }
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(self.topLabel.snp.bottom).offset(16.0)
        }
    }
    
}
