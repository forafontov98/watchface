//
//  WatchFacesTopView.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SnapKit
import AlignedCollectionViewFlowLayout

class WatchFacesTopView: UIView {

    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Clock faces".localized
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
        layout.minimumLineSpacing = 16.0
        layout.sectionInset.left = 16.0
        layout.sectionInset.right = 16.0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(TopWatchFaceCVC.self, forCellWithReuseIdentifier: TopWatchFaceCVC.className)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        cv.restorationIdentifier = CollectionViewType.popular.rawValue
        
        return cv
    }()
    
    private (set) var categoriesCollectionView: UICollectionView = {
        
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.sectionInset.left = 16.0
        layout.sectionInset.right = 16.0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(GroupCVC.self, forCellWithReuseIdentifier: GroupCVC.className)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alpha = 0.0
        
        cv.restorationIdentifier = CollectionViewType.categories.rawValue

        return cv
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        collectionView.clipsToBounds = false
        
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
        
        addSubview(categoriesCollectionView)
        
        categoriesCollectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topLabel.snp.bottom).offset(16.0)
            $0.height.equalTo(1000.0)
        }
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16.0)
            $0.height.equalTo(240.0)
        }
    }
}

extension WatchFacesTopView {
    func addCategoriesTarget(target: Any?, action: Selector) {
        categoriesButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension WatchFacesTopView {
    
    func categoriesOpenedState() {
        categoriesButton.setImage(UIImage(named: "cancel_btn_2"), for: .normal)

        UIView.animate(withDuration: 0.3) {
            self.categoriesCollectionView.alpha = 1.0
        }
    }
    
    func categoriesHiddenState() {
        categoriesButton.setImage(UIImage(named: "categories_icon"), for: .normal)

        UIView.animate(withDuration: 0.3) {
            self.categoriesCollectionView.alpha = 0.0
        }
    }
}

enum CollectionViewType: String {
    case categories = "categoriesCollectionView"
    case popular = "popularCollectionView"
}
