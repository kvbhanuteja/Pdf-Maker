//
//  UILabel+Extension.swift
//  Pankti Label Print
//
//  Created by bhanuteja on 27/12/23.
//

import UIKit

extension UILabel {
    
    func addUserInteration(target: Any?, action: Selector?) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
}
