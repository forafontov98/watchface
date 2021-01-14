//
//  WatchPreviewRouter.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit
import Hero

protocol IWatchPreviewRouter {
    func dismiss()
    func presentLockingScreen(delegate: LockingScreenPresenterDelegate?)

    func beganPanGesture(translation: CGPoint)
    func changePanGesture(translation: CGPoint, progress: CGFloat)
    func endPanGesture(progress: CGFloat, velocity: CGPoint)
    
    func presentAlertController(delegate: SetWatchACDelegate)
    func share(watchFace: UIImage)
    
    func presentGuideScreen()
}

class WatchPreviewRouter: NSObject, IWatchPreviewRouter {

    private weak var view: WatchPreviewVC?

    init(view: WatchPreviewVC) {
        self.view = view
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func presentLockingScreen(delegate: LockingScreenPresenterDelegate?) {
        let vc = LockingScreenBuilder().build(delegate: delegate)
        view?.present(vc, animated: true, completion: nil)
    }
    
    func beganPanGesture(translation: CGPoint) {
        view?.hero.dismissViewController()
    }
    
    func changePanGesture(translation: CGPoint, progress: CGFloat) {
        Hero.shared.update(progress)
                
        guard let view = view else {return}
        
        let currentPos = CGPoint(x: view.view.center.x, y: translation.y + view.view.center.y)
        Hero.shared.apply(modifiers: [.position(currentPos)], to: view.view)
    }
    
    func endPanGesture(progress: CGFloat, velocity: CGPoint) {
        guard let view = view else {return}

        if progress + velocity.y / view.view.bounds.height > 0.3 {
            Hero.shared.finish()
        } else {
            Hero.shared.cancel()
        }
    }
    
    func presentAlertController(delegate: SetWatchACDelegate) {
        
        let ac = SetWatchAC(title: "Find the line \"Create Watch Face\"".localized + "\n\n\n\n",
                            message: nil,
                            preferredStyle: .actionSheet)
        
        ac.delegate = delegate
        
        view?.present(ac, animated: true, completion: nil)
    }
    
    func share(watchFace: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [watchFace],
                                                              applicationActivities: nil)
        
        self.view?.present(activityViewController, animated: true, completion: nil)
    }
    
    func presentGuideScreen() {
        let vc = GuideScreenBuilder().build()
        self.view?.present(vc, animated: true, completion: nil)
    }
}
