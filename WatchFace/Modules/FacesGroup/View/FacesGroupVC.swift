//
//  FacesGroupVC.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit
import Hero

class FacesGroupVC: UIViewController {

    var mainView = FacesGroupView()
    
    private var presenter: IFacesGroupPresenter?
        
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

        navBarConfig()
        
        mainView.collectionView.dataSource = presenter
        mainView.collectionView.delegate = presenter
    }
    
    override func loadView() {
        view = mainView
    }
    
    func setPresenter(_ presenter: IFacesGroupPresenter) {
        self.presenter = presenter
    }
    
    func navBarConfig() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_button")
    }
}
