//
//  RoundBorderView.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {
    
    var pathColor: UIColor = UIColor.lightGray
    override func draw(_ rect: CGRect) {
        let rect = CGRect(x: 2, y: 2, width: self.frame.width-3, height: self.frame.height-3)
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 25)
        pathColor.set()
        roundedRect.lineWidth = 2
        roundedRect.close()
        roundedRect.stroke()
    }
    
    func setColor(_ color: UIColor){
        self.pathColor = color
        self.setNeedsDisplay()
    }
}
