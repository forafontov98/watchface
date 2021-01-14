//
//  ThirdScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class ThirdScreenVC: UIViewController {

    private var presenter: IWelcomeTourPresenter?
    
    var mainView: ThirdScreenView?
    
    init(sourceScreen: SourceScreen) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen

        hero.isEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var sourceScreen: SourceScreen?
    
    override func loadView() {
                
        presenter?.getProducts(callback: { [weak self] (weekPrice, monthPrice) in
            self?.mainView = ThirdScreenView(
                weekPrice: weekPrice,
                monthPrice: monthPrice)

            self?.view = self?.mainView

            self?.addTargets()
            self?.heroViewsConfig()
            self?.viewsConfig(sourceScreen: self?.sourceScreen)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc
    func nextBtnPressed() {
        presenter?.purchase()
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
        presenter?.restore()
    }
    
    @objc
    func weekBtnPressed() {
        mainView?.weekSelected()
        presenter?.weekBtnPressed()
    }
    
    @objc
    func monthBtnPressed() {
        mainView?.monthSelected()
        presenter?.monthBtnPressed()
    }
    
    private func addTargets() {
        mainView?.addNextBtnTarget(target: self, action: #selector(nextBtnPressed))
        mainView?.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
        
        mainView?.addPrivacyPolicyTarget(target: self, action: #selector(privacyBtnPressed))
        mainView?.addTermsTarget(target: self, action: #selector(termsBtnPressed))
        mainView?.addRestoreTarget(target: self, action: #selector(restoreBtnPressed))
        
        mainView?.addWeekSubscriptionTarget(target: self, action: #selector(weekBtnPressed))
        mainView?.addMonthSubscriptionTarget(target: self, action: #selector(monthBtnPressed))

    }
    
    private func viewsConfig(sourceScreen: SourceScreen?) {
        guard let sourceScreen = sourceScreen else {
            return
        }
        
        if sourceScreen == .app {
            mainView?.pageControl.isHidden = true
            mainView?.privacyBtn.isHidden = true
            mainView?.termsBtn.isHidden = true
            mainView?.subscriptionLabel.isHidden = true
            mainView?.restoreBtn.isHidden = true
        }
    }
}

extension ThirdScreenVC: WelcomeTourController {
    func setPresenter(_ presenter: IWelcomeTourPresenter) {
        self.presenter = presenter
    }
}

extension ThirdScreenVC {
    private func heroViewsConfig() {
        
        mainView?.leftWatchFace.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.2))]

        mainView?.centerWatchFace.heroModifiers = [.whenAppearing(.translate(y: -150.0), .fade, .delay(0.1))]
        
        mainView?.rightWatchFace.heroModifiers = [.whenAppearing(.translate(x: 150.0), .fade, .delay(0.2))]
        
        mainView?.topLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.3))]
        
        mainView?.firstOrangeCircle.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.5))]
        
        mainView?.firstSubscriptionLineLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.5))]
        
        mainView?.secondOrangeCircle.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.6))]
        
        mainView?.secondSubscriptionLineLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.6))]
        
        mainView?.monthSubscriptionBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.7))]
        
        mainView?.weekSubscriptionBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.8))]
        
        mainView?.subscriptionLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.9))]

        mainView?.nextBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(1.0))]
        
        mainView?.pageControl.heroModifiers = [.fade]
        mainView?.restoreBtn.heroModifiers = [.fade]
        mainView?.privacyBtn.heroModifiers = [.fade]
        mainView?.termsBtn.heroModifiers = [.fade]
    }
}
