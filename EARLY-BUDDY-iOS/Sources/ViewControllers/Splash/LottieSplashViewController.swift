//
//  LottieViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/04.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit
import Lottie

class LottieSplashViewController: UIViewController {
    
//    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = AnimationView()
        animationView.animation = Animation.named("splashJson")
        animationView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        self.view.addSubview(animationView)
        
        if animationView.animation?.duration == nil {
            guard let user = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "UserNavigationController") as? UINavigationController else { return }
            user.modalPresentationStyle = .fullScreen
            self.navigationController?.present(user, animated: true, completion: nil)
        } else {
            animationView.play { (finished) in
                guard let user = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "UserNavigationController") as? UINavigationController else { return }
                user.modalPresentationStyle = .fullScreen
                self.navigationController?.present(user, animated: true, completion: nil)
            }
        }
    }
}

