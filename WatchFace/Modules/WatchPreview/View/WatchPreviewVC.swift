//
//  WatchPreviewVC.swift
//  WatchFace
//
//  Created by MacBook on 10.12.2020.
//

import UIKit

class WatchPreviewVC: UIViewController {

    var mainView = WatchPreviewView()
    
    private var presenter: IWatchPreviewPresenter?
        
    private var groupName: String?
    
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
        mainView.addGestureRecognizer(panGR)
        
        if let watchFace = presenter?.watchFace {
            mainView.imageView.loadImageWithKingFisher(for: watchFace.url)
            
            if watchFace.status == .free {
                mainView.lockIcon.removeFromSuperview()
            }
        }
        
        mainView.topLabel.text = groupName
        
        heroViewsConfig()

        mainView.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
        mainView.addDownloadBtnTarget(target: self, action: #selector(downloadBtnPressed))

        if let watchFace = presenter?.watchFace {
            mainView.imageView.heroID = "watchFace_\(watchFace.url)"
            mainView.lockIcon.heroID = "lockIcon_\(watchFace.url)"
            mainView.dateAndTimeConfig()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    func setPresenter(_ presenter: IWatchPreviewPresenter) {
        self.presenter = presenter
    }
    
    func setGroupName(_ name: String?) {
        self.groupName = name
    }
    
    @objc
    func cancelBtnPressed() {
        presenter?.cancelBtnPressed()
    }
    
    @objc
    func downloadBtnPressed() {
        presenter?.downloadBtnPressed()
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

        mainView.blurView.heroModifiers = [.whenAppearing(.fade),
                                           .whenDisappearing(.fade, .delay(0.22))]
        
        mainView.topLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.1)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.19))]
        
        mainView.cancelBtn.heroModifiers = [.whenAppearing(.translate(x: 150.0), .fade, .delay(0.1)),
                                            .whenDisappearing(.translate(x: 150.0), .fade, .delay(0.19))]
        
        mainView.downloadBtn.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.19)),
                                              .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.1))]
        
        mainView.questionBtn.heroModifiers = [.whenAppearing(.translate(x: 150.0), .fade, .delay(0.19)),
                                              .whenDisappearing(.translate(x: 150.0), .fade, .delay(0.1))]
        
    }
}

extension WatchPreviewVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
