//
//  InAppProduct.swift
//  WatchFace
//
//  Created by MacBook on 08.01.2021.
//

import UIKit
import StoreKit

enum IAProduct: String, CaseIterable {
    case monthTrial = "month.trial.subscription"
    case weekTrial = "week.trial.subscription"
    case month = "month.subscription.wf"
    case week = "week.subscription.wf"
}

struct IAProductInfo {
    var id: IAProduct
    var value: SKProduct
}
