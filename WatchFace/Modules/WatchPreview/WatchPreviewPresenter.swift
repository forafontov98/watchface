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
    
    var watchFace: WatchFace? { get set }

}

class WatchPreviewPresenter: NSObject, IWatchPreviewPresenter {

    private weak var view: WatchPreviewVC?
    private var router: IWatchPreviewRouter?
    private var interactor: IWatchPreviewInteractor?
    
    var watchFace: WatchFace?

    init(view: WatchPreviewVC, router: IWatchPreviewRouter, interactor: IWatchPreviewInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func cancelBtnPressed() {
        router?.dismiss()
    }
    
    func downloadBtnPressed() {
        if let watchFace = watchFace, watchFace.status == .free {
            router?.presentAlertController(delegate: self)
        } else {
            router?.presentLockingScreen(delegate: self)
        }
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

extension WatchPreviewPresenter: SetWatchACDelegate {
    func notShowAgain() {
        
    }
    
    func gotIt() {
        router?.share(watchFace: view!.mainView.imageView.image!)
    }
}

extension WatchPreviewPresenter: LockingScreenPresenterDelegate {
    func adWatched() {
        watchFace?.status = .free
        
        view?.mainView.lockIcon.isHidden = true
        router?.presentAlertController(delegate: self)
    }
}
