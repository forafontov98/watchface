//
//  GuideScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 13.01.2021.
//

import UIKit

class GuideScreenVC: UIViewController {

    var presenter: IGuideScreenPresenter?
    
    @IBOutlet weak var installationGuideLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localize()
        
        presenter?.setCollectionViewDataSource(collectionView)
        presenter?.setCollectionViewDelegate(collectionView)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        presenter?.nextBtnPressed()
    }
    
    private func localize() {
        installationGuideLabel.text = "Installation guide".localized
        nextBtn.setTitle("Next".localized, for: .normal)
    }
}
