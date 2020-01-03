//
//  BusStopView.swift
//  EARLY-BUDDY-iOS
//
//  Created by 김현지 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class BusStopView: UIView {
    
    @IBOutlet var dotView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else { return }
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        dotView.layer.cornerRadius = dotView.bounds.height / 2
    }
    
    class func instanceFromNib() -> BusStopView {
        return UINib(nibName: "BusStopView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BusStopView
    }
}
