//
//  LockingScreenPresenter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

protocol ILockingScreenPresenter {
    func cancelBtnPressed()

    func beganPanGesture(translation: CGPoint)
    func changePanGesture(translation: CGPoint, progress: CGFloat)
    func endPanGesture(progress: CGFloat, velocity: CGPoint)
}

class LockingScreenPresenter: NSObject, ILockingScreenPresenter {

    private weak var view: LockingScreenVC?
    private var router: ILockingScreenRouter?
    private var interactor: ILockingScreenInteractor?
    
    init(view: LockingScreenVC, router: ILockingScreenRouter, interactor: ILockingScreenInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func cancelBtnPressed() {
        router?.dismiss()
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
}
