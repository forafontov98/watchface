//
//  StartScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 14.01.2021.
//

import UIKit

class StartScreenVC: UIViewController {

    let mainView = StartScreenView()
    
    var presenter: IStartScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.presentMainScreen()
    }
    
    override func loadView() {
        view = mainView
    }
}
