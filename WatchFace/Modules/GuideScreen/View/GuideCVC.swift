//
//  GuideCVC.swift
//  WatchFace
//
//  Created by MacBook on 13.01.2021.
//

import UIKit

class GuideCVC: UICollectionViewCell {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var guide: GuideScreenEntity? {
        didSet {
            guard let guide = guide else { return }
            
            topImageView.image = guide.image
            topLabel.text = guide.title
            descriptionLabel.text = guide.description
        }
    }
}
