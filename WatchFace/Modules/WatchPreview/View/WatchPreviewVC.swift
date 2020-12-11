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
    
    private var watchFace: UIImage?
    
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
        
        mainView.imageView.image = watchFace
        
        heroViewsConfig()

        mainView.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
        mainView.addDownloadBtnTarget(target: self, action: #selector(downloadBtnPressed))

    }
    
    override func loadView() {
        view = mainView
    }
    
    func setPresenter(_ presenter: IWatchPreviewPresenter) {
        self.presenter = presenter
    }
    
    func setWatchFace(_ image: UIImage?) {
        self.watchFace = image
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

        mainView.blurView.heroModifiers = [.whenAppearing(.translate(y: 150.0)),
                                           .whenDisappearing(.translate(y: 150.0), .delay(0.22))]
        
        mainView.topLabel.heroModifiers = [.whenAppearing(.translate(y: 150.0), .fade, .delay(0.1)),
                                           .whenDisappearing(.translate(y: 150.0), .fade, .delay(0.19))]
        
        mainView.cancelBtn.heroModifiers = [.whenAppearing(.translate(y: 150.0), .fade, .delay(0.13)),
                                            .whenDisappearing(.translate(y: 150.0), .fade, .delay(0.16))]
        
        mainView.imageView.heroModifiers = [.whenAppearing(.translate(y: 150.0), .fade, .delay(0.16)),
                                            .whenDisappearing(.translate(y: 150.0), .fade, .delay(0.13))]
        
        mainView.downloadBtn.heroModifiers = [.whenAppearing(.translate(y: 150.0), .fade, .delay(0.19)),
                                              .whenDisappearing(.translate(y: 150.0), .fade, .delay(0.1))]
        
        mainView.questionBtn.heroModifiers = [.whenAppearing(.translate(y: 150.0), .fade, .delay(0.22)),
                                              .whenDisappearing(.translate(y: 150.0), .fade)]
        
    }
}

extension WatchPreviewVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
