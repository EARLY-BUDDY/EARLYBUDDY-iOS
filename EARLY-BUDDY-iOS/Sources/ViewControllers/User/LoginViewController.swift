//
//  LoginViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    let fontRegular = "NotoSansKR-Regular"
    let fontMedium = "NotoSansKR-Medium"
    let icHomeSelect = UIImage(named: "icAutologinSelect")!
    let icHomeUnSelect  = UIImage(named: "icAutologinUnsel")!
    
    @IBOutlet weak var idErrorLabel: UILabel!
    @IBOutlet weak var pwErrorLabel: UILabel!
    
    @IBOutlet weak var idContainerView: RoundedCornerView!
    @IBOutlet weak var pwContainerView: RoundedCornerView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var autoLogin: CheckBoxButton!
    
    var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let imageView : UIImageView = UIImageView(image: UIImage(named: "backLogin.png")!)
        self.view.addSubview(imageView)
        autoLogin.setUpImage(icHomeSelect, icHomeUnSelect)
        autoLogin.isChecked = false
        setUpTextField(idTextField)
        setUpTextField(pwTextField)
        setUpLabel(idErrorLabel)
        setUpLabel(pwErrorLabel)
        idTextField.placeholder = "아이디를 입력해주세요."
        pwTextField.placeholder = "영어+숫자 6자 이상 입력해주세요."
        loginButton.backgroundColor = .lightGray
        loginButton.titleLabel?.font = UIFont(name: fontMedium, size: 18)
        loginButton.roundCorners(corners: [.allCorners], radius: 25)
        loginButton.isEnabled = false
    }
    
    func setUpView(_ view: UIView){
        view.backgroundColor = .white
    }
    func setUpTextField(_ textField: UITextField) {
        textField.font = UIFont(name: fontMedium, size: 16)
        textField.delegate = self
    }
    func setUpLabel(_ label: UILabel){
        label.font = UIFont(name: fontMedium, size: 14)
        label.textColor = .darkGray
    }
    @IBAction func LoginAction(_ sender: Any) {
        loginNetwork()
        self.goNextView()
    }
    
    func loginNetwork() {
        let id = gsno(idTextField.text)
        let passwd = gsno(pwTextField.text)
        print(id, passwd)
        UsersService.usersService.loginNetwork(id, passwd) { data in
            switch data {
            case .success(let data):
                print(" signupNetwork data : ", data)
                let result = data as? LoginResponse
                print(" result data : ", result)
            case .requestErr:
                print("경로를 찾지 못함")
            }
        }
    }
    
    func goNextView() {
        guard let nicknameVC = self.storyboard!.instantiateViewController(withIdentifier: "NickNameViewController") as? NickNameViewController else {
            return }
        nicknameVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nicknameVC, animated: true)
    }
    
    @IBAction func goSignUpAction(_ sender: Any) {
        guard let signUpVC = self.storyboard!.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {
            return }
        signUpVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func autoLoginButton(_ sender: CheckBoxButton) {
        sender.isChecked = !sender.isChecked
    }
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == idTextField {
            textFieldCheck(idTextField, idContainerView, idErrorLabel, "^[a-z]{1,}$", "영문 소문자만 사용해 주세요!")
        } else if textField == pwTextField {
            textFieldCheck(pwTextField, pwContainerView, pwErrorLabel, "^[a-z0-9]{6,}$", "형식에 맞게 사용해 주세요!")
        }
    }
    
    func textFieldCheck(_ tf: UITextField,_ cv: RoundedCornerView,_ errorLabel: UILabel,_ regex: String, _ alert: String) {
        if !textFieldNullCheck(tf,cv, errorLabel) {
        } else if !gsno(tf.text).hasCharacter(regex: regex) {
            cv.setColor(.ff6E6E)
            errorLabel.text = alert
            errorLabel.textColor = .ff6E6E
        } else {
            cv.setColor(.lightGray)
            errorLabel.text = " "
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
        if textField == idTextField {
            idContainerView.setColor(.mainblue)
        } else {
            if idContainerView.pathColor == .mainblue {
                idContainerView.setColor(.lightGray)
            }
        }
        if textField == pwTextField {
            pwContainerView.setColor(.mainblue)
        } else {
            if pwContainerView.pathColor == .mainblue {
                pwContainerView.setColor(.lightGray)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if gsno(idTextField.text).hasCharacter(regex: "^[a-z]{1,}$") &&
            gsno(pwTextField.text).hasCharacter(regex: "^[a-z0-9]{6,}$") {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .mainblue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
}
