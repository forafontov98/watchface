//
//  WatchFacesListRouter.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SideMenu

protocol IWatchFacesListRouter {
    func presentMenu()
    func presentFacesGroup()
    func presentWatchPreview(_ image: UIImage?)
}

class WatchFacesListRouter: IWatchFacesListRouter {

    private weak var view: WatchFacesListVC?

    init(view: WatchFacesListVC) {
        self.view = view
    }
        
    func presentMenu() {
        let menu = LeftMenuBuilder().build()
        view?.present(menu, animated: true, completion: nil)
    }
    
    func presentFacesGroup() {
        let vc = FacesGroupBuilder().build()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentWatchPreview(_ image: UIImage?) {
        let vc = WatchPreviewBuilder().build(image: image)
        view?.present(vc, animated: true, completion: nil)
    }
}
