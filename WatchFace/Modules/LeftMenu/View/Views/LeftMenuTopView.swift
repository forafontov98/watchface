//
//  LeftMenuTopView.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class LeftMenuTopView: UIView {
    
    private (set) var cancelBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel_btn"), for: .normal)
        return button
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings".localized
        label.font = .systemFont(ofSize: 33.0, weight: .bold)
        label.textColor = UIColor(named: "darkTextColor")
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16.0)
            $0.top.equalTo(self.snp.topMargin).offset(16.0)
            $0.width.height.equalTo(20.0)
        }
        
        addSubview(settingsLabel)
        
        settingsLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16.0)
            $0.top.equalTo(self.cancelBtn.snp.bottom).offset(16.0)
            $0.right.equalTo(self.snp.right).offset(-16.0)
        }
    }
    
}

extension LeftMenuTopView {
    
    func addCancelBtnTarget(target: Any?, action: Selector) {
        cancelBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
