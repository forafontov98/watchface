//
//  FirstScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

protocol WelcomeTourController {
    func setPresenter(_ presenter: IWelcomeTourPresenter)
}

class FirstScreenVC: UIViewController {

    private var presenter: IWelcomeTourPresenter?
    
    var mainView = FirstScreenView()

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

        heroViewsConfig()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func heroViewsConfig() {
        
        /*
        mainView.imageView.heroModifiers = [.whenAppearing(.translate(y: -150.0), .fade, .delay(0.1)),
                                           .whenDisappearing(.translate(y: -150.0), .fade, .delay(0.4))]
        */
        mainView.topLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.2)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.5))]
        
        mainView.centerLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.3)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.4))]
        
        mainView.bottomLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.4)),
                                              .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.3))]
        
        mainView.nextBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.5)),
                                              .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.2))]
    }
}

extension FirstScreenVC: WelcomeTourController {
    func setPresenter(_ presenter: IWelcomeTourPresenter) {
        self.presenter = presenter
    }
}
