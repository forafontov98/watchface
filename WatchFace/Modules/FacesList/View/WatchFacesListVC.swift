//
//  WatchFacesListVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SideMenu

class WatchFacesListVC: UIViewController {

    var mainView = WatchFacesView()

    private var presenter: IWatchFacesListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarConfig()

        configLeftMenu()
        
        mainView.tableView.dataSource = presenter
        mainView.tableView.delegate = presenter
        
        mainView.tableHeaderView?.collectionView.dataSource = presenter
        mainView.tableHeaderView?.collectionView.delegate = presenter
        
        let vc = WelcomeTourBuilder().build(screen: .first)
        present(vc, animated: true, completion: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    func setPresenter(_ presenter: IWatchFacesListPresenter) {
        self.presenter = presenter
    }
    
    func navBarConfig() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
                
        navigationItem.title = ""
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(leftMenuBtnPressed))
        
        navigationController?.navigationBar.tintColor = UIColor(named: "darkTextColor")
    }
    
    @objc
    func leftMenuBtnPressed() {
        presenter?.presentMenu()
    }
}

extension WatchFacesListVC {
    private func configLeftMenu() {
        let _ = LeftMenuBuilder().build()
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}
