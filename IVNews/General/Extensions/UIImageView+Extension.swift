//
//  UIImageView+Extension.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    /// Load the image from url
    /// - Parameters:
    ///   - urlString: url to be loaded
    ///   - placeHolder: placeholder image
    ///   - completionHandler: Image is provided on completion if needed
    func imageFromServerUsing(urlString: String, placeHolder: UIImage?, completionHandler: ((UIImage)->(Void))? = nil) {
        DispatchQueue.main.async {
            self.image = placeHolder ?? nil
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            completionHandler?(cachedImage)
            return
        }
        APIService.shared.getImage(urlString: urlString) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let downloadedImage):
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                    completionHandler?(downloadedImage)
                case .failure(let error):
                    debugPrint("ERROR LOADING IMAGES FROM URL: \(error.localizedDescription)")
                    self.image = placeHolder
                }
            }
        }
    }
    
   
}
