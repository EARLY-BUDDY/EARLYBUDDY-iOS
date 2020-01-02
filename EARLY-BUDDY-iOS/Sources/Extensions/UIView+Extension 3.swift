//
//  UIView+Extension.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/27.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

extension UIView {
    
    open override func awakeFromNib() {
        if self.tag == 1 {
            self.layer.cornerRadius = 19
        } else if self.tag == 2 {
            self.layer.cornerRadius = 10
        }
    }
    
}
