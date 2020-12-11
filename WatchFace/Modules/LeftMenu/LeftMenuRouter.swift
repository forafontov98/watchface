//
//  LeftMenuRouter.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

protocol ILeftMenuRouter {
    func cancelBtnPressed()
}

class LeftMenuRouter: NSObject, ILeftMenuRouter {

    private weak var view: LeftMenuVC?
    
    init(view: LeftMenuVC) {
        self.view = view
    }
    
    func cancelBtnPressed() {
        view?.dismiss(animated: true, completion: nil)
    }
}
