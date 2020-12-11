//
//  WatchFacesView.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

class WatchFacesView: UIView {

    private (set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(CategoryTVC.self, forCellReuseIdentifier: CategoryTVC.className)
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 180.0
        tableView.estimatedRowHeight = 180.0
        
        tableView.tableHeaderView = WatchFacesTopView()
        tableView.tableHeaderView?.frame.size.height = 340.0
        
        return tableView
    }()
    
    var tableHeaderView: WatchFacesTopView? {
        get {
            if let header = tableView.tableHeaderView as? WatchFacesTopView {
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
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.top.equalTo(self.snp.topMargin)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}
