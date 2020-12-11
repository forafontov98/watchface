//
//  Extensions.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

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
