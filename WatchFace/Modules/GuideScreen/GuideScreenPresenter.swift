//
//  GuideScreenPresenter.swift
//  WatchFace
//
//  Created by MacBook on 13.01.2021.
//

import UIKit

protocol IGuideScreenPresenter {
    func setCollectionViewDataSource(_ collectionView: UICollectionView)
    func setCollectionViewDelegate(_ collectionView: UICollectionView)
    func nextBtnPressed()
}

class GuideScreenPresenter: NSObject, IGuideScreenPresenter {

    private weak var view: GuideScreenVC?
    private var router: IGuideScreenRouter?
    
    private var currentPage = 0
    
    private var guides: [GuideScreenEntity] = [
        GuideScreenEntity(title: "Step 1".localized,
                          description: "Choose your favorite watch face and click \"Save\"".localized,
                          image: UIImage(named: "watch_7")),
        
        GuideScreenEntity(title: "Step 2".localized,
                          description: "Allow photo access to save your watch faces".localized,
                          image: UIImage(named: "alert")),
        
        GuideScreenEntity(title: "Step 3".localized,
                          description: "Click on the saved watch face in the gallery.".localized + " " + "Next, click on the \"Share\" button and select the \"Create Watch face\" option".localized,
                          image: UIImage(named: "share")),
        
        GuideScreenEntity(title: "Step 4".localized,
                          description: "Select the desired option and click \"Add\"".localized,
                          image: UIImage(named: "watchface_share")),
    ]
    
    init(view: GuideScreenVC, router: IGuideScreenRouter) {
        self.view = view
        self.router = router
    }
    
    func setCollectionViewDataSource(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
    }

    func setCollectionViewDelegate(_ collectionView: UICollectionView) {
        collectionView.delegate = self
    }
    
    func nextBtnPressed() {
        currentPage += 1
        
        view?.collectionView.scrollToItem(
            at: IndexPath(row: currentPage, section: 0),
            at: .centeredVertically,
            animated: true)
    }

}

extension GuideScreenPresenter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "guideCell",
            for: indexPath) as! GuideCVC
        
        cell.guide = guides[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width,
                      height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        view?.pageControl.currentPage = currentPage
    }
}
