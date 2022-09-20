//
//  UIimage+StringUrlToImage.swift
//  Project communction app
//
//  Created by Macbook on 05/09/2022.
//

import Foundation
import UIKit


extension UIImageView { 
    
    
    // To Convert the photo from the string to Image
     func SetImageFromStringUrl(StringUrl : String){
        
        if let url = URL(string: StringUrl){
            if let imageData = try?Data(contentsOf: url){
                self.image = UIImage(data: imageData)
                  
            }
        }
    }
    
    
    // to make the photo circle
    func makeCircularImage(){
        self.layer.cornerRadius = self.frame.width / 2
        
    }
    
    
    
}
