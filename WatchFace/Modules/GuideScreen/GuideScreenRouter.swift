//
//  GuideScreenRouter.swift
//  WatchFace
//
//  Created by MacBook on 13.01.2021.
//

import UIKit

protocol IGuideScreenRouter {
    
}

class GuideScreenRouter: NSObject, IGuideScreenRouter {
    
    private weak var view: GuideScreenVC?

    init(view: GuideScreenVC) {
        self.view = view
    }
    
}
