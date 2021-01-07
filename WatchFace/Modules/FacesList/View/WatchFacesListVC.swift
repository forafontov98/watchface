//
//  WatchFacesListVC.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SideMenu
import SkeletonView

class WatchFacesListVC: UIViewController {

    var mainView = WatchFacesView()

    private var presenter: IWatchFacesListPresenter?

    /* Значение высоты collectionView групп */
    var groupCollectionViewHeight: CGFloat {
        guard let tableHeaderView = mainView.tableHeaderView else { return 0.0 }
        return tableHeaderView.categoriesCollectionView.contentSize.height + 16.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navBarConfig()

        configLeftMenu()
        
        mainView.tableView.dataSource = presenter
        mainView.tableView.delegate = presenter
        
        mainView.tableHeaderView?.collectionView.dataSource = presenter
        mainView.tableHeaderView?.collectionView.delegate = presenter
        
        mainView.tableHeaderView?.categoriesCollectionView.dataSource = presenter
        mainView.tableHeaderView?.categoriesCollectionView.delegate = presenter
                
        addTargets()
        
        presenter?.getWatchList()
        
        //presenter?.presentWelcomeTour()
        
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    func addTargets() {
        mainView.tableHeaderView?.addCategoriesTarget(target: self, action: #selector(categoriesBtnPressed))
    }
    
    @objc
    func leftMenuBtnPressed() {
        presenter?.presentMenu()
    }
    
    @objc
    func categoriesBtnPressed() {
        presenter?.categoriesBtnPressed()
    }
    
    func categoriesOpenedState() {
        mainView.tableHeaderView?.categoriesOpenedState()
        
        mainView.tableView.beginUpdates()
        
        UIView.animate(withDuration: 0.3) {
            self.mainView.tableView.tableHeaderView?.frame.size.height += self.groupCollectionViewHeight
            self.mainView.tableView.tableHeaderView?.layoutIfNeeded()
        }
        
        mainView.tableView.endUpdates()
    }
    
    func categoriesHiddenState() {
        mainView.tableHeaderView?.categoriesHiddenState()
        
        mainView.tableView.beginUpdates()

        UIView.animate(withDuration: 0.3) {
            self.mainView.tableView.tableHeaderView?.frame.size.height -= self.groupCollectionViewHeight
            self.mainView.tableView.tableHeaderView?.layoutIfNeeded()
        }
        
        mainView.tableView.endUpdates()
    }
}

extension WatchFacesListVC {
    private func configLeftMenu() {
        let _ = LeftMenuBuilder().build()
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}
