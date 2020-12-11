//
//  SecondScreenVC.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class SecondScreenVC: UIViewController {

    private var presenter: IWelcomeTourPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SecondScreenVC: WelcomeTourController {
    func setPresenter(_ presenter: IWelcomeTourPresenter) {
        self.presenter = presenter
    }
}
