//
//  checkButton.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {
    // Images
    var checkedImage = UIImage()
    var uncheckedImage = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isChecked = false
    }
    
    func setUpImage(_ selectImg: UIImage,_ unselectImg: UIImage){
        self.checkedImage = selectImg
        self.uncheckedImage = unselectImg
        self.setNeedsDisplay()
    }
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
}
