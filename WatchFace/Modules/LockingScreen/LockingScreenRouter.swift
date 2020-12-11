//
//  LockingScreenRouter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit
import Hero

protocol ILockingScreenRouter {
    func dismiss()
    
    func beganPanGesture(translation: CGPoint)
    func changePanGesture(translation: CGPoint, progress: CGFloat)
    func endPanGesture(progress: CGFloat, velocity: CGPoint)
}

class LockingScreenRouter: NSObject, ILockingScreenRouter {

    private weak var view: LockingScreenVC?

    init(view: LockingScreenVC) {
        self.view = view
    }
    
    func dismiss() {
        self.view?.dismiss(animated: true, completion: nil)
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
}
