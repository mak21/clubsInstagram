//
//  Extensions.swift
//  ClubsInstagram
//
//  Created by mahmoud khudairi on 4/14/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UITextField: UITextFieldDelegate{
//    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.resignFirstResponder()
//        return true
//    }
    
    
}
extension UIImageView {
   
    func circlerImage(){
               self.layer.cornerRadius = self.frame.height/2
                   self.layer.masksToBounds = true
    }
    
    

    
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
      
    
       //self.image = nil //it wasn't working before that !!
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}


