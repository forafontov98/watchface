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
    
    private let panGR = UIPanGestureRecognizer()
            
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
        
        presenter?.viewConfig()
        
        mainView.topLabel.text = groupName
        
        heroViewsConfig()

        addTargets()
        
        if let watchFace = presenter?.watchFace {
            mainView.imageView.loadImageWithKingFisher(for: watchFace.url_full)
            mainView.imageView.heroID = "watchFace_\(watchFace.url_mini)"
            mainView.lockIcon.heroID = "lockIcon_\(watchFace.url_mini)"
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
    
    func setImage(_ image: UIImage?) {
        self.mainView.imageView.image = image
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
    func questionBtnPressed() {
        presenter?.presentGuideScreen()
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
    
    @objc
    func tap() {
        presenter?.cancelBtnPressed()
    }
    
    func setStepLabel(_ val: String) {
        DispatchQueue.main.async {
            self.mainView.stepLabel.text = val
        }
    }
    
    private func addTargets() {
        panGR.addTarget(self, action: #selector(pan))
        panGR.delegate = self
        mainView.addGestureRecognizer(panGR)

        mainView.addCancelBtnTarget(target: self, action: #selector(cancelBtnPressed))
        mainView.addDownloadBtnTarget(target: self, action: #selector(downloadBtnPressed))
        mainView.addQuestionBtnTarget(target: self, action: #selector(questionBtnPressed))
    }
    
    private func heroViewsConfig() {

        mainView.blurView.heroModifiers = [.whenAppearing(.fade),
                                           .whenDisappearing(.fade, .delay(0.22))]
        
        mainView.topLabel.heroModifiers = [.whenAppearing(.translate(x: -150.0), .fade, .delay(0.1)),
                                           .whenDisappearing(.translate(x: -150.0), .fade, .delay(0.19))]
        
        mainView.cancelIcon.heroModifiers = [.whenAppearing(.translate(x: 150.0), .fade, .delay(0.1)),
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
