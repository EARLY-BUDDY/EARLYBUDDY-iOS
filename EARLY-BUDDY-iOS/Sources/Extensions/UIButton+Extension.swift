//
//  UIButton+Extension.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/25.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

extension UIButton {
    
    open override func awakeFromNib() {
        if self.tag == 1 {
            self.layer.cornerRadius = 18
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.mainblue.cgColor
        }
        
        if self.tag == 2 {
            self.layer.cornerRadius = 15
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightgray.cgColor
        }
        
        if self.tag == 3 {
            self.layer.cornerRadius = 15
            self.layer.backgroundColor = UIColor.mainblue.cgColor
            self.setTitleColor(UIColor.white, for: .normal)
        }
        
        if self.tag == 4 {
            self.layer.cornerRadius = 18
        }
        
        if self.tag == 5 {
            self.layer.cornerRadius = 18
            self.layer.borderColor = UIColor.mainblue.cgColor
            self.layer.borderWidth = 1
        }
        
        if self.tag == 6 {
            self.layer.cornerRadius = 25
        }

    }
}
