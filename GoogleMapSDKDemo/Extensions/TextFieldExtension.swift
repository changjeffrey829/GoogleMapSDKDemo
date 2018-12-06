//
//  TextFieldExtension.swift
//  GoogleMapSDKDemo
//
//  Created by Jeffrey Chang on 12/3/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit
import CoreLocation
//import GooglePlaces

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func returnIntTextValue() -> Int? {
        if let text = self.text {
            return Int(text)
        }
        return nil
    }
    
}
