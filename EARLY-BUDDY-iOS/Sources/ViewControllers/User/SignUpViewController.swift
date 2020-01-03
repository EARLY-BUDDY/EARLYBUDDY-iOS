//
//  SignUpViewController.swift
//  EARLY-BUDDY-iOS
//
//  Created by 박경선 on 2020/01/02.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    let fontRegular = "NotoSansKR-Regular"
    let fontMedium = "NotoSansKR-Medium"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idContainerView: RoundedCornerView!
    @IBOutlet weak var passwdContainerView: RoundedCornerView!
    @IBOutlet weak var pwCheckContainerView: RoundedCornerView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwdLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    @IBOutlet weak var idErrorLable: UILabel!
    @IBOutlet weak var passwdErrorLabel: UILabel!
    @IBOutlet weak var pwCheckErrorLabel: UILabel!
    
    let idLine = CALayer()
    let passwdLine = CALayer()
    let pwCheckLine = CALayer()
    var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        originY = self.view.frame.origin.y
        let imageView : UIImageView = UIImageView(image: UIImage(named: "backSignup.png")!)
        self.view.addSubview(imageView)
        titleLabel.numberOfLines = 0
        titleLabel.text = "회원가입 후\n얼리버디와 함께해요!"
        titleLabel.font = UIFont(name: fontRegular, size: 26)!
        setUpView(idContainerView)
        setUpView(passwdContainerView)
        setUpView(pwCheckContainerView)
        setUpTextField(idTextField)
        setUpTextField(passwdTextField)
        setUpTextField(pwCheckTextField)
        idTextField.placeholder = "아이디를 입력해주세요."
        passwdTextField.placeholder = "영어+숫자 6자 이상 입력해주세요."
        pwCheckTextField.placeholder = "비밀번호를 한 번 더 입력해주세요."
        setUpLabel(idLabel)
        setUpLabel(passwdLabel)
        setUpLabel(pwCheckLabel)
        signUpButton.backgroundColor = .lightGray
        signUpButton.titleLabel?.font = UIFont(name: fontMedium, size: 18)
        signUpButton.roundCorners(corners: [.allCorners], radius: 25)
        idErrorLable.font = UIFont(name: fontMedium, size: 12)
        passwdErrorLabel.font = UIFont(name: fontMedium, size: 12)
        pwCheckErrorLabel.font = UIFont(name: fontMedium, size: 12)
//        signUpButton.isEnabled = false
    }
    
    func signupNetwork() {
        let id = gsno(idTextField.text)
        let passwd = gsno(passwdTextField.text)
        var resultData: SignUpResponse!
        UsersService.usersService.signupNetwork(id, passwd) { data in
            switch data {
            case .success(let data):
                print(" signupNetwork data : ",data)
                resultData = data as? SignUpResponse
                print("resultData : ", resultData)
            case .requestErr:
                print("경로를 찾지 못함")
            }
        }
    }
    
    @IBAction func SignUpButtonAction(_ sender: Any) {
        let sub = UIView(frame: self.view.frame)
        sub.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.view.addSubview(sub)

        let myAlert = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCompleteViewController") as! SignUpCompleteViewController
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        myAlert.onFinished = { [weak self] in
            self?.goLoginView()
        }
        signupNetwork()
//        if signupNetwork() {
            self.present(myAlert, animated: true, completion: nil)
//        } else {
//            print("xxxxxxxx")
//        }
    }
    
    func goLoginView(){
        guard let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return }
        loginVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == idTextField {
            textFieldCheck(idTextField, idContainerView, idErrorLable, "^[a-z]{1,}$", "영문 소문자만 사용해 주세요!")
        } else if textField == passwdTextField {
            textFieldCheck(passwdTextField, passwdContainerView, passwdErrorLabel, "^[a-z0-9]{6,}$", "형식에 맞게 사용해 주세요!")
        } else if textField == pwCheckTextField {
            textFieldCheck(pwCheckTextField, pwCheckContainerView, pwCheckErrorLabel, passwdTextField.text!, "비밀번호가 다릅니다!")
        }
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
    
    
    func textFieldCheck(_ tf: UITextField,_ cv: RoundedCornerView,_ errorLabel: UILabel,_ regex: String, _ alert: String) {
        textFieldNullCheck(tf,cv, errorLabel)
        if !gsno(tf.text).hasCharacter(regex: regex) {
            cv.setColor(.ff6E6E)
            errorLabel.text = alert
            errorLabel.textColor = .ff6E6E
        } else {
            cv.setColor(.lightGray)
            errorLabel.text = " "
        }
    }
    
    func textFieldNullCheck(_ tf: UITextField,_ cv: RoundedCornerView,_ label: UILabel) {
        if tf.text == "" {
            cv.setColor(.ff6E6E)
            label.text = "값을 입력해주세요"
            label.textColor = .ff6E6E
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == idTextField {
            idContainerView.setColor(.mainblue)
        } else {
            if idContainerView.pathColor == .mainblue {
                idContainerView.setColor(.lightGray)
            }
        }
        if textField == passwdTextField {
            passwdContainerView.setColor(.mainblue)
        } else {
            if passwdContainerView.pathColor == .mainblue {
                passwdContainerView.setColor(.lightGray)
            }
        }
        if textField == pwCheckTextField {
            pwCheckContainerView.setColor(.mainblue)
        } else {
            if pwCheckContainerView.pathColor == .mainblue {
                pwCheckContainerView.setColor(.lightGray)
            }
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if gsno(idTextField.text).hasCharacter(regex: "^[a-z]{1,}$") &&
            gsno(passwdTextField.text).hasCharacter(regex: "^[a-z0-9]{6,}$") &&
            pwCheckTextField.text! == passwdTextField.text! {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .mainblue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .lightGray
        }
    }
    
    
}
