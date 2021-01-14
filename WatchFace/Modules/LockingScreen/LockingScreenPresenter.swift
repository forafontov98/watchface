//
//  LockingScreenPresenter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit
import GoogleMobileAds

protocol ILockingScreenPresenter {
    func cancelBtnPressed()

    func beganPanGesture(translation: CGPoint)
    func changePanGesture(translation: CGPoint, progress: CGFloat)
    func endPanGesture(progress: CGFloat, velocity: CGPoint)
    
    func presentSubscriptionScreen()
    func presentAdScreen()

    func loadAd()

}

protocol LockingScreenPresenterDelegate {
    func adWatched()
}

class LockingScreenPresenter: NSObject, ILockingScreenPresenter {

    private weak var view: LockingScreenVC?
    private var router: ILockingScreenRouter?
    private var interactor: ILockingScreenInteractor?
    
    var delegate: LockingScreenPresenterDelegate?
    
    private var didEarned = false

    init(view: LockingScreenVC, router: ILockingScreenRouter, interactor: ILockingScreenInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func cancelBtnPressed() {
        router?.dismiss { }
    }
    
    func beganPanGesture(translation: CGPoint) {
        guard translation.y > 0.0 else { return }

        router?.beganPanGesture(translation: translation)
    }
    
    func changePanGesture(translation: CGPoint, progress: CGFloat) {
        guard translation.y > 0.0 else { return }
            
        router?.changePanGesture(translation: translation, progress: progress)
    }
    
    func endPanGesture(progress: CGFloat, velocity: CGPoint) {
        router?.endPanGesture(progress: progress, velocity: velocity)
    }
    
    func presentSubscriptionScreen() {
        router?.presentSubscriptionScreen()
    }
    
    func presentAdScreen() {
        guard let rewardedAd = interactor?.getRewardedAd() else {
            return
        }
        
        if rewardedAd.isReady {
            interactor?.sendAdStartEvent()
            router?.presentAdScreen(rewardedAd: rewardedAd, delegate: self)
        } else {
            view?.mainView.loadingState = true
        }
    }
        
    func loadAd() {
        interactor?.loadAd(completion: { (success) in
            let loadingState = self.view?.mainView.loadingState
            
            if let loadingState = loadingState, loadingState {
                self.view?.mainView.loadingState = false
                self.presentAdScreen()
            }
        })
    }
    
}

extension LockingScreenPresenter: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        interactor?.sendAdFinishEvent()
        didEarned = true
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        if didEarned {
            router?.dismiss {
                self.delegate?.adWatched()
            }
        } else {
            loadAd()
        }
    }
    
}
