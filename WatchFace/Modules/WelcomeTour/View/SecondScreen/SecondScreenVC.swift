//
//  SecondScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class SecondScreenVC: UIViewController {

    private var presenter: IWelcomeTourPresenter?
    
    var mainView = SecondScreenView()

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
        presenter?.presentThirdScreen()
    }
    
    private func addTargets() {
        mainView.addNextBtnTarget(target: self, action: #selector(nextBtnPressed))
    }
}

extension SecondScreenVC {
    private func heroViewsConfig() {
        
        mainView.leftWatchFace.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.4)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.6))]

        mainView.centerWatchFace.heroModifiers = [.whenAppearing(.translate(y: -150.0), .fade, .delay(0.1)),
                                                  .whenDisappearing(.translate(y: -150.0), .fade, .delay(0.6))]
        
        mainView.rightWatchFace.heroModifiers = [.whenAppearing(.translate(x: 150.0), .fade, .delay(0.4)),
                                                  .whenDisappearing(.translate(x: 150.0), .fade, .delay(0.6))]
        
        mainView.topLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.3)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.5))]
        
        mainView.centerLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.4)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.4))]
        
        mainView.bottomLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.5)),
                                              .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.3))]
        
        mainView.nextBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.6)),
                                              .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.1))]
        
        mainView.pageControl.heroModifiers = [.fade]
    }
}

extension SecondScreenVC: WelcomeTourController {
    func setPresenter(_ presenter: IWelcomeTourPresenter) {
        self.presenter = presenter
    }
}
