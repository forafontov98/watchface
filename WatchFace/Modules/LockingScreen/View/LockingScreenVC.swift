//
//  LockingScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class LockingScreenVC: UIViewController {

    var mainView = LockingScreenView()
    
    private var presenter: ILockingScreenPresenter?
    
    private var panGR = UIPanGestureRecognizer()

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        
        hero.isEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGR.addTarget(self, action: #selector(pan))
        panGR.delegate = self
        view.addGestureRecognizer(panGR)
        
        heroViewsConfig()
        
        mainView.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
    }
    
    override func loadView() {
        view = mainView
    }
    
    func setPresenter(_ presenter: ILockingScreenPresenter) {
        self.presenter = presenter
    }
    
    @objc
    func cancelBtnPressed() {
        presenter?.cancelBtnPressed()
    }
    
    @objc
    func pan() {
        let translation = panGR.translation(in: nil)
        let progress = translation.y / 0.8 / view.bounds.height
        
        switch panGR.state {
        case .began:
            presenter?.beganPanGesture(translation: translation)
        case .changed:
            presenter?.changePanGesture(translation: translation, progress: progress)
        default:
            presenter?.endPanGesture(progress: progress, velocity: panGR.velocity(in: nil))
            
        }
    }
    
    private func heroViewsConfig() {
        mainView.blurView.heroModifiers = [.whenAppearing(.translate(y: 150.0)),
                                           .whenDisappearing(.translate(y: 150.0), .delay(0.2))]

        mainView.grayView.heroModifiers = [.whenAppearing(.translate(y: 150.0), .fade, .delay(0.2)),
                                           .whenDisappearing(.translate(y: 150.0), .fade, .delay(0.0))]
        
    }
}

extension LockingScreenVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
