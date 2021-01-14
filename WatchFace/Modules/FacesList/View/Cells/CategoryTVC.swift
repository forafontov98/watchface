//
//  CategoryTVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

protocol CategoryTVCDelegate: class {
    func showAllBtnPressed(_ indexPath: IndexPath)
    func watchPreviewPressed(cell: CategoryTVC, indexPath: IndexPath, _ watch: WatchFace)
}

class CategoryTVC: UITableViewCell {

    weak var delegate: CategoryTVCDelegate?
    
    private (set) var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "darkTextColor")
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let showAllButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "darkTextColor"), for: .normal)
        button.setTitle("More".localized, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .medium)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    private (set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 111.0, height: 134.0)
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
    
    var watchCategory: WatchCategory? {
        didSet {
            guard let watchCategory = watchCategory else { return }
            
            nameLabel.text = watchCategory.name
            collectionView.reloadData()

        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        makeConstraints()
        addTargets()
        
        collectionView.dataSource = self
        collectionView.delegate = self

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
            $0.height.equalTo(134.0)
        }
    }
    
    @objc
    func showAllBtnPressed() {
        if let indexPath = indexPath {
            delegate?.showAllBtnPressed(indexPath)
        }
    }
}

extension CategoryTVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = watchCategory {
            return category.watches.count > 5 ? 5 : category.watches.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchFaceCVC.className, for: indexPath) as! WatchFaceCVC
        
        cell.watch = watchCategory?.watches[indexPath.row]
        
        if SwiftyStoreService.shared.isPro {
            cell.lockIcon.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let watch = watchCategory?.watches[indexPath.row], let ip = self.indexPath {
            delegate?.watchPreviewPressed(cell: self, indexPath: ip, watch)
        }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
