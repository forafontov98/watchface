//
//  LeftMenuView.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class LeftMenuView: UIView {

    private (set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(LeftMenuTVC.self, forCellReuseIdentifier: LeftMenuTVC.className)
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 50.0
        tableView.estimatedRowHeight = 50.0
        
        tableView.tableHeaderView = LeftMenuTopView()
        tableView.tableHeaderView?.frame.size.height = 120.0
        
        return tableView
    }()
    
    var tableHeaderView: LeftMenuTopView? {
        get {
            if let header = tableView.tableHeaderView as? LeftMenuTopView {
                return header
            }
            
            return nil
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(self.snp.topMargin)
        }
    }
    
}
