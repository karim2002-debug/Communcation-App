//
//  ShadowView.swift
//  Project communction app
//
//  Created by Macbook on 06/09/2022.
//

import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super .init(frame: frame)
        setShadow()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setShadow()
     }
    
    
    func setShadow(){
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 10
        
    }
    

}
