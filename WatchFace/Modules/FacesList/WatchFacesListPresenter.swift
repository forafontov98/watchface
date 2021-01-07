//
//  WatchFacesListPresenter.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SkeletonView

protocol IWatchFacesListPresenter: SkeletonTableViewDataSource, UITableViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegate {
    func presentMenu()
    func getWatchList()
    
    func presentWelcomeTour()
    func categoriesBtnPressed()
}

class WatchFacesListPresenter: NSObject, IWatchFacesListPresenter {

    private weak var view: WatchFacesListVC?
    private var interactor: IWatchFacesListInteractor?
    private var router: IWatchFacesListRouter?
    
    /* Массив всех категорий */
    private var categories: [WatchCategory] = []
    
    /* Массив выбранных категорий */
    private var selectedCategories: [WatchCategory] = [] {
        didSet {
            view?.mainView.tableView.reloadData()
        }
    }
    
    /* Массив категорий для отображения */
    private var categoriesToPresent: [WatchCategory] {
        if selectedCategories.isEmpty {
            if categories.isEmpty {
                return []
            } else {
                return Array(categories[1..<categories.count])
            }

        } else {
            return selectedCategories
        }
    }
    
    private var categoriesOpened = false

    init(view: WatchFacesListVC, interactor: IWatchFacesListInteractor, router: IWatchFacesListRouter) {
        super.init()
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func presentMenu() {
        router?.presentMenu()
    }
    
    func getWatchList() {
        interactor?.watchListRequest(callback: { (categories) in
            self.categories = categories
            
            self.view?.mainView.tableView.reloadData()
            self.view?.mainView.tableHeaderView?.collectionView.reloadData()
            self.view?.mainView.tableHeaderView?.categoriesCollectionView.reloadData()
        })
    }
    
    func presentWelcomeTour() {
        router?.presentWelcomeTour()
    }

    
    func categoriesBtnPressed() {
        if categoriesOpened {
            view?.categoriesHiddenState()
        } else {
            view?.categoriesOpenedState()
        }
        
        categoriesOpened = !categoriesOpened
    }
}

extension WatchFacesListPresenter: CategoryTVCDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return CategoryTVC.className
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesToPresent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTVC.className, for: indexPath) as! CategoryTVC
        
        cell.delegate = self
        cell.watchCategory = categoriesToPresent[indexPath.row]
        
        return cell
    }
    
    func showAllBtnPressed(_ indexPath: IndexPath) {
        router?.presentFacesGroup(categoriesToPresent[indexPath.row])
    }
    
    func watchPreviewPressed(indexPath: IndexPath, _ watch: WatchFace) {
        let group = categoriesToPresent[indexPath.row]
        router?.presentWatchPreview(watch, groupName: group.name)
    }
}
 
extension WatchFacesListPresenter: UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TopWatchFaceCVC.className
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let id = collectionView.restorationIdentifier else { return 0 }
        guard let type = CollectionViewType(rawValue: id) else { return 0 }
        
        switch type {
        case .categories:
            return categories.count - 1
            
        case .popular:
            return categories.first?.watches.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let id = collectionView.restorationIdentifier else { return UICollectionViewCell() }
        guard let type = CollectionViewType(rawValue: id) else { return UICollectionViewCell() }
        
        switch type {
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCVC.className, for: indexPath) as! GroupCVC
            let category = categories[indexPath.row + 1]
            
            cell.group = categories[indexPath.row + 1]
            cell.isSelected = selectedCategories.contains(where: { $0 === category })
            
            return cell
            
        case .popular:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopWatchFaceCVC.className, for: indexPath) as! TopWatchFaceCVC
            cell.watch = categories.first?.watches[indexPath.row]
           
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let id = collectionView.restorationIdentifier else { return }
        guard let type = CollectionViewType(rawValue: id) else { return }
        
        switch type {
        case .categories:
            let category = categories[indexPath.row + 1]
            
            if selectedCategories.contains(where: { $0 === category }) {
                selectedCategories.removeAll(where: {$0 === category})
            } else {
                selectedCategories.append(category)
            }
            
            collectionView.reloadData()
            
        case .popular:
            if let group = categories.first {
                let watch = group.watches[indexPath.row]
                router?.presentWatchPreview(watch, groupName: group.name)
            }
            
        }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let id = collectionView.restorationIdentifier else { return .zero }
        guard let type = CollectionViewType(rawValue: id) else { return .zero }
        
        switch type {
        case .categories:
            
            let group = categories[indexPath.row + 1]
            let label = UILabel()
            label.font = .systemFont(ofSize: 13.0, weight: .bold)
            label.text = group.name
            label.sizeToFit()
            
            return CGSize(width: label.frame.width + 24.0, height: 40)
            
        case .popular:
            return CGSize(width: 194.0, height: 240.0)
        }
    }
}
