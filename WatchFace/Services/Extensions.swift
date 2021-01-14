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

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

// MARK:- NotificationCenter extension

var Notify = NotificationCenter.default
extension NotificationCenter {
    func add(_ observer: Any, _ selector: Selector, name: String, _ object: Any? = nil) {
        addObserver(observer, selector: selector, name: NSNotification.Name(name), object: object)
    }
    
    func post(name: String, object: Any? = nil) {
        post(name: NSNotification.Name(name), object: object)
    }
}
