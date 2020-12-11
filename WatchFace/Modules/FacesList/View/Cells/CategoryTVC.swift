//
//  CategoryTVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

protocol CategoryTVCDelegate: class {
    func showAllBtnPressed(_ indexPath: IndexPath)
}

class CategoryTVC: UITableViewCell {

    weak var delegate: CategoryTVCDelegate?
    
    private (set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "darkTextColor")
        label.text = "Category"
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let showAllButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "darkTextColor"), for: .normal)
        button.setTitle("Show all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .medium)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    private (set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 91.0, height: 110.0)
        layout.minimumLineSpacing = 16.0
        layout.sectionInset.left = 11.0
        layout.sectionInset.right = 11.0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(WatchFaceCVC.self, forCellWithReuseIdentifier: WatchFaceCVC.className)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.tag = 1
        
        return cv
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        makeConstraints()
        addTargets()
    }
    
    func addTargets() {
        showAllButton.addTarget(self, action: #selector(showAllBtnPressed), for: .touchUpInside)
    }
    
    func makeConstraints() {
        self.selectionStyle = .none
        
        contentView.addSubview(showAllButton)
        
        showAllButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16.0)
            $0.top.equalToSuperview().offset(16.0)
            $0.width.equalTo(60.0)
        }
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16.0)
            $0.top.equalToSuperview().offset(16.0)
            $0.right.equalTo(self.showAllButton.snp.left).offset(-10.0)
        }
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(showAllButton.snp.bottom).offset(16.0)
            $0.height.equalTo(110.0)
        }
    }
    
    @objc
    func showAllBtnPressed() {
        if let indexPath = indexPath {
            delegate?.showAllBtnPressed(indexPath)
        }
    }
}
