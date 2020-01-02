//
//  LetterSpacing.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2019/12/26.
//  Copyright © 2019 김현지. All rights reserved.
//

import UIKit

extension UILabel {
    
    func labelKern(kerningValue: CGFloat) {
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.kern: kerningValue, NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: self.textColor!])
    }
    
}

extension UITextView {
    
    func labelKern(kerningValue: CGFloat) {
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.kern: kerningValue, NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: self.textColor!])
    }
    
}

extension UITextField {
    
    func labelKern(kerningValue: CGFloat) {
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.kern: kerningValue, NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: self.textColor!])
    }
    
}
