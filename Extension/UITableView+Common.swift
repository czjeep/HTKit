//
//  UITableView+Common.swift
//  HiLeia6
//
//  Created by caozheng on 2021/10/19.
//

import UIKit

extension UITableView {
    
    func dequeueReusableNibCellWithClass<T: UITableViewCell>(cellClass: T.Type) -> T {
        let className = String(describing: cellClass)
        if let cell = dequeueReusableCell(withIdentifier: className) as? T {
            return cell
        }
        
//        let nib = UINib(nibName: className, bundle: nil)
        let nib = T.nib()
        register(nib, forCellReuseIdentifier: className)
        let cell = dequeueReusableCell(withIdentifier: className) as! T
        return cell
    }
    
    func dequeueReusableClassCellWithClass<T: UITableViewCell>(cellClass: T.Type) -> T {
        let className = String(describing: cellClass)
        if let cell = dequeueReusableCell(withIdentifier: className) as? T {
            return cell
        }
        
        register(cellClass, forCellReuseIdentifier: className)
        let cell = dequeueReusableCell(withIdentifier: className) as! T
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass viewClass: T.Type) -> T? {
        let className = String(describing: viewClass)
        if let obj = dequeueReusableHeaderFooterView(withIdentifier: className) as? T {
            return obj
        }
        
        register(viewClass, forHeaderFooterViewReuseIdentifier: className)
        let obj = dequeueReusableHeaderFooterView(withIdentifier: className) as? T
        return obj
    }
    
    func deselect(_ animated: Bool) {
        guard let index = indexPathForSelectedRow else {
            return
        }
        deselectRow(at: index, animated: animated)
    }
}
