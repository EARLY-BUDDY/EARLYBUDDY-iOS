//
//  NickNameViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class NickNameViewController: UIViewController {
    let fontRegular = "NotoSansKR-Regular"
    let fontMedium = "NotoSansKR-Medium"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickNameErrorLabel: UILabel!
    @IBOutlet weak var nickNameContainerView: RoundedCornerView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let imageView : UIImageView = UIImageView(image: UIImage(named: "backFirst.png")!)
        self.view.addSubview(imageView)
        titleLabel.numberOfLines = 0
        titleLabel.text = "얼리버디와 함께할\n닉네임을 설정해주세요."
        titleLabel.font = UIFont(name: fontRegular, size: 26)!
        setUpTextField(nickNameTextField)
        nickNameTextField.placeholder = "한글 6글자 이내로 적어주세요."
        registerButton.backgroundColor = .lightGray
        registerButton.titleLabel?.font = UIFont(name: fontMedium, size: 18)
        registerButton.roundCorners(corners: [.allCorners], radius: 25)
        registerButton.isEnabled = false
    }

    func setUpTextField(_ textField: UITextField) {
        textField.font = UIFont(name: fontMedium, size: 16)
        textField.delegate = self
    }
    func setUpLabel(_ label: UILabel){
        label.font = UIFont(name: fontMedium, size: 14)
        label.textColor = .darkGray
    }
    
    @IBAction func registerAction(_ sender: Any) {
        guard let favoriteVC = self.storyboard!.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController else {
            return }
        favoriteVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
}

extension NickNameViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !textFieldNullCheck(nickNameTextField, nickNameContainerView, nickNameErrorLabel) {
        } else if !gsno(nickNameTextField.text).hasCharacter(regex: "^[ㄱ-ㅎㅏ-ㅣ가-힣]{1,}$") {
            nickNameContainerView.setColor(.ff6E6E)
            nickNameErrorLabel.text = "한글만 적어 주세요!"
            nickNameErrorLabel.textColor = .ff6E6E
        } else {
            nickNameContainerView.setColor(.lightGray)
            nickNameErrorLabel.text = " "
        }
    }
    
    func textFieldNullCheck(_ tf: UITextField,_ cv: RoundedCornerView,_ label: UILabel) -> Bool {
        if tf.text == "" {
            cv.setColor(.ff6E6E)
            label.text = "값을 입력해주세요"
            label.textColor = .ff6E6E
            return false
        } else { return true }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        self.view.frame.origin.y -= 50
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = originY
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nickNameContainerView.setColor(.mainblue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if gsno(nickNameTextField.text).hasCharacter(regex: "^[ㄱ-ㅎㅏ-ㅣ가-힣]{1,}$") {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .mainblue
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .lightGray
        }
    }
    
}
