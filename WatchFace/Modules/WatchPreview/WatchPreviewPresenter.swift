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
    func viewConfig()

    func presentGuideScreen()
}

class WatchPreviewPresenter: NSObject, IWatchPreviewPresenter {

    private weak var view: WatchPreviewVC?
    private var router: IWatchPreviewRouter?
    private var interactor: IWatchPreviewInteractor?
    
    var watchFace: WatchFace?

    init(view: WatchPreviewVC, router: IWatchPreviewRouter, interactor: IWatchPreviewInteractor) {
        super.init()
        
        self.view = view
        self.router = router
        self.interactor = interactor
        
        Notify.add(self, #selector(self.viewConfig), name: Keys.purchase_state_changed)

    }
    
    @objc
    func viewConfig() {
        guard let watchFace = watchFace else {
            return
        }
        
        view?.mainView.imageView.loadImageWithKingFisher(for: watchFace.url_mini)
            
        if watchFace.status == .free || interactor?.isPro ?? false {
            view?.mainView.lockIcon.removeFromSuperview()
        }
        
        if watchFace.isGif() {
            view?.mainView.questionBtn.isHidden = false
        } else {
            view?.mainView.questionBtn.isHidden = true
            view?.mainView.questionBtn.snp.makeConstraints {
                $0.width.equalTo(0.0)
            }
        }
    }

    
    func cancelBtnPressed() {
        router?.dismiss()
    }
    
    func downloadBtnPressed() {
        let isPro = interactor?.isPro ?? false
        
        if let watchFace = watchFace, watchFace.status == .free || isPro {

            if watchFace.isGif() {
                
                view?.mainView.downloadBtn.load(true)
                interactor?.loadAndSaveGif(watchFace: watchFace, callback: { (step) in
                    switch step {
                    case .loading:
                        self.view?.setStepLabel("1/4: " + "Loading".localized)
                        
                    case .dataToMov(let progress, let units):
                        let percents: Int = units > 0 ? Int(Double(progress) * 100.0 / Double(units)) : 0
                        self.view?.setStepLabel("2/4: " + "Conversion to".localized + " .mov: \(percents) %")

                    case .movToLive(let progress):
                        let percents: Int = Int(progress * 100.0)
                        self.view?.setStepLabel("3/4: " + "Conversion to".localized + " Live Photo: \(percents) %")
                        
                    case .done:
                        self.view?.setStepLabel("4/4: " + "Done, set the watch face from the gallery".localized)
                        self.view?.mainView.downloadBtn.load(false)
                    }
                })
                
            } else {
                guard let interactor = interactor else {
                    return
                }
                
                if interactor.needToShowHelpAlert() {
                    router?.presentAlertController(delegate: self)
                } else {
                    if let image = view?.mainView.imageView.image {
                        router?.share(watchFace: image)
                    }
                }
            }
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
    
    func presentGuideScreen() {
        router?.presentGuideScreen()
    }
}

extension WatchPreviewPresenter: SetWatchACDelegate {
    func notShowAgain() {
        if let image = view?.mainView.imageView.image {
            interactor?.notShowAgain()
            router?.share(watchFace: image)
        }
    }
    
    func gotIt() {
        if let image = view?.mainView.imageView.image {
            router?.share(watchFace: image)
        }
    }
}

extension WatchPreviewPresenter: LockingScreenPresenterDelegate {
    func adWatched() {
        watchFace?.status = .free
        
        view?.mainView.lockIcon.isHidden = true
        downloadBtnPressed()
    }
}
