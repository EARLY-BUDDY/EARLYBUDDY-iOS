//
//  LoginEndViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/03.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class LoginEndViewController: UIViewController {
    let fontRegular = "NotoSansKR-Regular"
    let fontMedium = "NotoSansKR-Medium"
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isSkip: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
    }
    
    func setInit(){
        let imageView : UIImageView = UIImageView(image: UIImage(named: "backFirstFinsh.png")!)
        self.view.addSubview(imageView)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: fontRegular, size: 18)!
        startButton.backgroundColor = .mainblue
        startButton.titleLabel?.font = UIFont(name: fontMedium, size: 18)
        startButton.roundCorners(corners: [.allCorners], radius: 25)
        
        if isSkip! {
            titleLabel.text = "자주 가는 장소는 마이페이지에서\n언제든지 바꿀 수 있어요."
        } else {
            titleLabel.text = "앞으로 얼리버디와 같이\n약속에 나가볼까요?"
        }
    }
    
    @IBAction func startAction(_ sender: Any) {
        guard let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController else { return }
        main.modalPresentationStyle = .fullScreen
        self.navigationController?.present(main, animated: true, completion: nil)
    }
    

}
