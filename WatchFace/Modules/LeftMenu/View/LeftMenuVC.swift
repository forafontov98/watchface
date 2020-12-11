//
//  LeftMenuVC.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class LeftMenuVC: UIViewController {

    var mainView = LeftMenuView()
    
    private var presenter: ILeftMenuPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTargets()
        
        mainView.tableView.dataSource = presenter
        mainView.tableView.delegate = presenter
    }
    
    func setPresenter(_ presenter: ILeftMenuPresenter) {
        self.presenter = presenter
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func setTargets() {
        mainView.tableHeaderView?.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
    }
    
    @objc
    func cancelBtnPressed() {
        presenter?.cancelBtnPressed()
    }
}
