//
//  GuideScreenBuilder.swift
//  WatchFace
//
//  Created by MacBook on 13.01.2021.
//

import UIKit

class GuideScreenBuilder: NSObject {

    func build() -> UIViewController {
        let vc = UIStoryboard(name: "GuideScreen", bundle: nil).instantiateViewController(withIdentifier: "GuideScreenVC") as! GuideScreenVC
        
        let router = GuideScreenRouter(view: vc)
        let presenter = GuideScreenPresenter(view: vc, router: router)
        
        vc.presenter = presenter
        
        return vc
    }
    
}
