//
//  FacesGroupPresenter.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

protocol IFacesGroupPresenter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func cancelBtnPressed()
}

class FacesGroupPresenter: NSObject, IFacesGroupPresenter {
    
    private weak var view: FacesGroupVC?
    private var router: IFacesGroupRouter?
    private var interactor: IFacesGroupInteractor?
    
    init(view: FacesGroupVC, router: IFacesGroupRouter, interactor: IFacesGroupInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func cancelBtnPressed() {
        router?.cancelBtnPressed()
    }
}

extension FacesGroupPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchFaceCVC.className, for: indexPath)

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
        router?.presentWatchPreview(UIImage(named: "Apple Watch 44mm"))
    }
}
