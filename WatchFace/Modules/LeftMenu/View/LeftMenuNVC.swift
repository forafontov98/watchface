//
//  LeftMenuNVC.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit
import SideMenu

class LeftMenuNVC: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationOptions = .curveEaseInOut
        presentationStyle = .viewSlideOutMenuPartialIn

        menuWidth = UIScreen.main.bounds.width - 40.0
        leftSide = true
        
        setNavigationBarHidden(true, animated: false)
    }
    
}
