//
//  Extensions.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import Kingfisher

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    var indexPath: IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        
        return superView.indexPath(for: self)
    }
    
}

extension UICollectionViewCell {
    var indexPath: IndexPath? {
        guard let superView = self.superview as? UICollectionView else {
            print("superview is not a UICollectionView - getIndexPath")
            return nil
        }
        
        return superView.indexPath(for: self)
    }
}

extension UIImageView {
    
    func loadImageWithKingFisher(for urlString: String) {
        
        self.kf.cancelDownloadTask()
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            self.image = nil
            return
        }
        
        let resourse = ImageResource(downloadURL: url, cacheKey: urlString)
        
        let cache = ImageCache.default
        
        if cache.isCached(forKey: urlString) {

            self.kf.setImage(
            with: resourse,
            placeholder: self.image,
            options: [
                .onlyFromCache
            ])

        } else {

            self.kf.setImage(
            with: resourse,
            placeholder: self.image,
            options: [
                .transition(.fade(0.2)),
                .forceTransition,
                .keepCurrentImageWhileLoading
            ])

        }
    }
}
