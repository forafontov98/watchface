//
//  WatchFacesListPresenter.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

protocol IWatchFacesListPresenter: UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    func presentMenu()
}

class WatchFacesListPresenter: NSObject, IWatchFacesListPresenter {

    private weak var view: WatchFacesListVC?
    private var interactor: IWatchFacesListInteractor?
    private var router: IWatchFacesListRouter?
    
    init(view: WatchFacesListVC, interactor: IWatchFacesListInteractor, router: IWatchFacesListRouter) {
        super.init()
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func presentMenu() {
        router?.presentMenu()
    }
}

extension WatchFacesListPresenter: CategoryTVCDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTVC.className, for: indexPath) as! CategoryTVC
        
        cell.delegate = self
        cell.collectionView.dataSource = self
        
        return cell
    }
    
    func showAllBtnPressed(_ indexPath: IndexPath) {
        router?.presentFacesGroup()
    }
}
 
extension WatchFacesListPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopWatchFaceCVC.className, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchFaceCVC.className, for: indexPath)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.presentWatchPreview(UIImage(named: "Apple Watch 44mm"))
    }
}
