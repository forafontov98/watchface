//
//  AppEventsService.swift
//  WatchFace
//
//  Created by MacBook on 14.01.2021.
//

import UIKit
import YandexMobileMetrica
import FacebookCore

protocol IAppEventsService {
    func sendAdStartEvent()
    func sendAdFinishEvent()
    func sendTrialStartEvent()
    func sendPurchaseEvent() 
}

class AppEventsService: IAppEventsService {

    func sendAdStartEvent() {
        sendEvents(with: EventKeys.start_ad)
    }
    
    func sendAdFinishEvent() {
        sendEvents(with: EventKeys.finished_ad)
    }
    
    func sendTrialStartEvent() {
        sendEvents(with: EventKeys.start_trial)
    }
    
    func sendPurchaseEvent() {
        sendEvents(with: EventKeys.purchase)
    }
    
    private func sendEvents(with key: String) {
        // send to AppMetrika
        YMMYandexMetrica.reportEvent(key, onFailure: nil)
        
        // send to Facebook
        AppEvents.logEvent(.init(key))
    }
}
