//
//  LockingScreenRouter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit
import Hero
import GoogleMobileAds

protocol ILockingScreenRouter {
    func dismiss(completion: @escaping()->Void)
    
    func beganPanGesture(translation: CGPoint)
    func changePanGesture(translation: CGPoint, progress: CGFloat)
    func endPanGesture(progress: CGFloat, velocity: CGPoint)
    
    func presentSubscriptionScreen()
    func presentAdScreen(rewardedAd: GADRewardedAd?, delegate: GADRewardedAdDelegate)
    
    func presentSpinner()
    func hideSpinner(completion: @escaping()->Void)
}

class LockingScreenRouter: NSObject, ILockingScreenRouter {

    private weak var view: LockingScreenVC?

    init(view: LockingScreenVC) {
        self.view = view
    }
    
    func dismiss(completion: @escaping()->Void) {
        self.view?.dismiss(animated: true, completion: completion)
    }
    
    func beganPanGesture(translation: CGPoint) {
        view?.hero.dismissViewController()
    }
    
    func changePanGesture(translation: CGPoint, progress: CGFloat) {
        Hero.shared.update(progress)
                
        guard let view = view else {return}
        
        let currentPos = CGPoint(x: view.view.center.x, y: translation.y + view.view.center.y)
        Hero.shared.apply(modifiers: [.position(currentPos)], to: view.view)
    }
    
    func endPanGesture(progress: CGFloat, velocity: CGPoint) {
        guard let view = view else {return}

        if progress + velocity.y / view.view.bounds.height > 0.3 {
            Hero.shared.finish()
        } else {
            Hero.shared.cancel()
        }
    }
    
    func presentSubscriptionScreen() {
        let vc = WelcomeTourBuilder().build(screen: .third)
        view?.present(vc, animated: true, completion: nil)
    }
    
    func presentAdScreen(rewardedAd: GADRewardedAd?, delegate: GADRewardedAdDelegate) {
        if let view = view {
            rewardedAd?.present(fromRootViewController: view, delegate: delegate)
        }
    }
    
    var spinner: SpinnerVC?
    
    func presentSpinner() {
        spinner = SpinnerVC()
        view?.present(spinner!, animated: false, completion: nil)
    }
    
    func hideSpinner(completion: @escaping()->Void) {
        spinner?.dismiss(animated: false, completion: completion)
    }
}
