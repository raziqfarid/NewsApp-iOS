//
//  Extension.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Set the cell identifier same as class name so that this can be used across
    static var identifier: String {
        String(describing: self)
    }
}

extension UIViewController{
    /// Set the controller identifier same as class name so that this can be used across
    static var identifier: String {
        String(describing: self)
    }
}
