//
//  ThirdScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class ThirdScreenVC: UIViewController {

    private var presenter: IWelcomeTourPresenter?
    
    var mainView = ThirdScreenView()

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        
        hero.isEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTargets()
        heroViewsConfig()
    }
    
    override func loadView() {
        view = mainView
    }
    
    @objc
    func nextBtnPressed() {
        
    }
    
    @objc
    func cancelBtnPressed() {
        presenter?.cancelBtnPressed()
    }
    
    @objc
    func privacyBtnPressed() {
        presenter?.presentPrivacyScreen()
    }
    
    @objc
    func termsBtnPressed() {
        presenter?.presentTermsScreen()
    }
    
    @objc
    func restoreBtnPressed() {
        
    }
    
    private func addTargets() {
        mainView.addNextBtnTarget(target: self, action: #selector(nextBtnPressed))
        mainView.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
        
        mainView.addPrivacyPolicyTarget(target: self, action: #selector(privacyBtnPressed))
        mainView.addTermsTarget(target: self, action: #selector(termsBtnPressed))
        mainView.addRestoreTarget(target: self, action: #selector(restoreBtnPressed))
    }
}

extension ThirdScreenVC: WelcomeTourController {
    func setPresenter(_ presenter: IWelcomeTourPresenter) {
        self.presenter = presenter
    }
}

extension ThirdScreenVC {
    private func heroViewsConfig() {
        
        mainView.leftWatchFace.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.2))]

        mainView.centerWatchFace.heroModifiers = [.whenAppearing(.translate(y: -150.0), .fade, .delay(0.1))]
        
        mainView.rightWatchFace.heroModifiers = [.whenAppearing(.translate(x: 150.0), .fade, .delay(0.2))]
        
        mainView.topLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.3))]
        
        mainView.firstOrangeCircle.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.5))]
        
        mainView.firstSubscriptionLineLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.5))]
        
        mainView.secondOrangeCircle.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.6))]
        
        mainView.secondSubscriptionLineLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.6))]
        
        mainView.monthSubscriptionBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.7))]
        
        mainView.yearSubscriptionBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.8))]
        
        mainView.subscriptionLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.9))]

        mainView.nextBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(1.0))]
        
        mainView.pageControl.heroModifiers = [.fade]
        mainView.restoreBtn.heroModifiers = [.fade]
        mainView.privacyBtn.heroModifiers = [.fade]
        mainView.termsBtn.heroModifiers = [.fade]
    }
}
