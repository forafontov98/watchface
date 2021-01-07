//
//  LockingScreenInteractor.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import Foundation
import GoogleMobileAds

protocol ILockingScreenInteractor {
    func loadAd(completion: @escaping(Bool)->Void)
    func getRewardedAd() -> GADRewardedAd?
}

class LockingScreenInteractor: ILockingScreenInteractor {

    private var rewardedAd: GADRewardedAd?
    
    func loadAd(completion: @escaping(Bool)->Void) {
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        
        rewardedAd?.load(GADRequest()) { error in
            if let _ = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func getRewardedAd() -> GADRewardedAd? {
        return rewardedAd
    }
}
