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
    func presentFacesGroup(_ category: WatchCategory)
    func presentWatchPreview(_ watch: WatchFace?, groupName: String?)
    
    func presentWelcomeTour()
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
    
    func presentFacesGroup(_ category: WatchCategory) {
        let vc = FacesGroupBuilder().build(category: category)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentWatchPreview(_ watch: WatchFace?, groupName: String?) {
        let vc = WatchPreviewBuilder().build(watch: watch, groupName: groupName)
        view?.present(vc, animated: true, completion: nil)
    }
    
    func presentWelcomeTour() {
        let vc = WelcomeTourBuilder().build(screen: .first)
        view?.present(vc, animated: true, completion: nil)
    }
}
