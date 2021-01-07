//
//  FacesGroupRouter.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

protocol IFacesGroupRouter {
    func cancelBtnPressed()
    
    func presentWatchPreview(_ watch: WatchFace?, groupName: String?)
}

class FacesGroupRouter: IFacesGroupRouter {
    
    private weak var view: FacesGroupVC?

    init(view: FacesGroupVC) {
        self.view = view
    }
    
    func cancelBtnPressed() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func presentWatchPreview(_ watch: WatchFace?, groupName: String?) {
        let vc = WatchPreviewBuilder().build(watch: watch, groupName: groupName)
        view?.present(vc, animated: true, completion: nil)
    }
}
