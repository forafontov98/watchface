//
//  GroupCVC.swift
//  WatchFace
//
//  Created by MacBook on 07.01.2021.
//

import UIKit

class GroupCVC: UICollectionViewCell {
    
    private (set) var groupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        label.textColor = UIColor(named: "darkTextColor")
        label.textAlignment = .center
        
        return label
    }()
    
    private (set) var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(named: "darkTextColor")?.cgColor
        
        return view
    }()
    
    var group: WatchCategory? {
        didSet {
            guard let group = group else { return }
            
            groupLabel.text = group.name
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                groupLabel.textColor = .white
                cornerView.backgroundColor = UIColor(named: "darkTextColor")
            } else {
                groupLabel.textColor = UIColor(named: "darkTextColor")
                cornerView.backgroundColor = .clear
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        contentView.addSubview(cornerView)
        
        cornerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(groupLabel)
        
        groupLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
