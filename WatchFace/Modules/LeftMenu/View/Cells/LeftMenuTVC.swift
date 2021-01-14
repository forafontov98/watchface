//
//  LeftMenuTVC.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class LeftMenuTVC: UITableViewCell {

    private let itemName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19.0, weight: .semibold)
        label.textColor = UIColor(named: "darkTextColor")
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        makeConstraints()
    }
    
    func makeConstraints() {
        addSubview(itemName)
        
        itemName.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(16.0)
            $0.centerY.equalToSuperview()
        }
    }
}

extension LeftMenuTVC {
    
    func config(_ val: String) {
        backgroundColor = UIColor(hex: "F7F7F7")
        itemName.text = val
    }
    
}
