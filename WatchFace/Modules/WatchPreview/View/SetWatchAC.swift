//
//  SetWatchAC.swift
//  WatchFace
//
//  Created by MacBook on 06.01.2021.
//

import UIKit

protocol SetWatchACDelegate {
    func notShowAgain()
    func gotIt()
}

class SetWatchAC: UIAlertController {

    var delegate: SetWatchACDelegate?
    
    var imageFrame: CGRect {
        let width = view.frame.width
        return CGRect(x: 20.0, y: 35.0, width: width - 55.0, height: 60.0)
    }
    
    var imageView: UIImageView {
        let imageView = UIImageView(frame: imageFrame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "create_watchface")
        
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        
        addActions()
    }
    
    private func addActions() {
        addAction(UIAlertAction(title: "Don't show it again".localized, style: .default, handler: {_ in
            self.delegate?.notShowAgain()
        }))
        
        addAction(UIAlertAction(title: "Download".localized, style: .default, handler: {_ in
            self.delegate?.gotIt()
        }))
        
        addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: {_ in
            
        }))
    }
}
