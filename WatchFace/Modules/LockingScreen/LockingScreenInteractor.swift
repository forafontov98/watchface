//
//  LockingScreenInteractor.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import Foundation
import GoogleMobileAds
import YandexMobileMetrica

protocol ILockingScreenInteractor {
    func loadAd(completion: @escaping(Bool)->Void)
    func getRewardedAd() -> GADRewardedAd?
    
    func sendAdStartEvent()
    func sendAdFinishEvent()
}

class LockingScreenInteractor: ILockingScreenInteractor {

    private var rewardedAd: GADRewardedAd?
    
    private var eventService: IAppEventsService = AppEventsService()
    
    func loadAd(completion: @escaping(Bool)->Void) {
        rewardedAd = GADRewardedAd(adUnitID: SDKKeys.adUnitId)
        
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
    
    func sendAdStartEvent() {
        eventService.sendAdStartEvent()
    }
    
    func sendAdFinishEvent() {
        eventService.sendAdFinishEvent()
    }
    
}
