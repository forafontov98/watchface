//
//  FacesGroupPresenter.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

protocol IFacesGroupPresenter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func cancelBtnPressed()
    func setCategory(_ category: WatchCategory?)
}

class FacesGroupPresenter: NSObject, IFacesGroupPresenter {
    
    private weak var view: FacesGroupVC?
    private var router: IFacesGroupRouter?
    private var interactor: IFacesGroupInteractor?
    
    private var category: WatchCategory?

    init(view: FacesGroupVC, router: IFacesGroupRouter, interactor: IFacesGroupInteractor) {
        super.init()
        
        self.view = view
        self.router = router
        self.interactor = interactor
        
        Notify.add(self, #selector(self.updateViewIfNeeded), name: Keys.purchase_state_changed)

    }
    
    @objc
    func updateViewIfNeeded() {
        view?.mainView.collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func cancelBtnPressed() {
        router?.cancelBtnPressed()
    }
    
    func setCategory(_ category: WatchCategory?) {
        self.category = category
        
        view?.mainView.topLabel.text = category?.name
    }
    
}

extension FacesGroupPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.watches.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchFaceCVC.className, for: indexPath) as! WatchFaceCVC

        cell.watch = category?.watches[indexPath.row]
        
        if SwiftyStoreService.shared.isPro {
            cell.lockIcon.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let view = view?.view else {
            return .zero
        }
        
        let itemWidth = (view.frame.width - 52.0) / 3
        return CGSize(width: itemWidth, height: itemWidth * 1.22)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let watch = category?.watches[indexPath.row]
        let image = (collectionView.cellForItem(at: indexPath) as? WatchFaceCVC)?.previewImageView.image
        
        router?.presentWatchPreview(watch, image: image, groupName: category?.name)
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
