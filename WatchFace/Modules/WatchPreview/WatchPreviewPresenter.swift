//
//  WatchPreviewPresenter.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit
import Hero

protocol IWatchPreviewPresenter {
    func cancelBtnPressed()
    func downloadBtnPressed()

    func beganPanGesture(translation: CGPoint)
    func changePanGesture(translation: CGPoint, progress: CGFloat)
    func endPanGesture(progress: CGFloat, velocity: CGPoint)
}

class WatchPreviewPresenter: NSObject, IWatchPreviewPresenter {

    private weak var view: WatchPreviewVC?
    private var router: IWatchPreviewRouter?
    private var interactor: IWatchPreviewInteractor?
    
    init(view: WatchPreviewVC, router: IWatchPreviewRouter, interactor: IWatchPreviewInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func cancelBtnPressed() {
        router?.dismiss()
    }
    
    func downloadBtnPressed() {
        router?.presentLockingScreen()
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
