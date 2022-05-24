//
//  RegistrationViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 16.04.2022.
//

import UIKit
import JGProgressHUD

class RegistrationViewController: UIViewController {

    let networkManager = ServiceLocator.registrationNetworkManager()
    let keycheinStorageManager = ServiceLocator.keycheinStorageManager()
    let progressHUD = JGProgressHUD()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBAction func onClickDoneButton(_ sender: Any) {
        checkedTransitionToTabBarController()
    }
    
    var inputTextFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        settingInputTextFields(textFields: loginTextField, passwordTextField, repeatPasswordTextField)
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
        setHUD()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    func settingInputTextFields(textFields: UITextField...) {
        for textField in textFields {
            textField.delegate = self
            textField.indent(size: 24)
            inputTextFields.append(textField)
        }
    }
    
    func setHUD() {
        progressHUD.textLabel.text = "Loading"
        progressHUD.style = JGProgressHUDStyle.dark
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        guard let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        scrollView.contentInset.bottom = keyboardHeight
        
        for textField in inputTextFields {
            if textField.isFirstResponder {
                UIView.animate(withDuration: 0.25) {
                    let viewHeight = self.view.frame.height
                    let textFieldHeight = textField.frame.height
                    let heightViewWithoutKeyboard = viewHeight - keyboardHeight
                    let textFieldY = textField.frame.origin.y
                    let textFieldPosition = CGPoint(x: 1, y: textFieldY - heightViewWithoutKeyboard / 2 + textFieldHeight / 2)
                    self.scrollView.contentOffset = textFieldPosition
                }
            }
        }
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentInset = .zero
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func checkedTransitionToTabBarController() {
        progressHUD.show(in: self.view)
        if passwordTextField.text != repeatPasswordTextField.text {
            AppSnackBar.showSnackBar(in: self.view, message: "Пароли не совпадают")
            progressHUD.dismiss()
            return
        }
        networkManager.checkUsername(username: loginTextField.text ?? "") { [ weak self ] (checkResponse, error) in
            if let error = error?.localizedDescription {
                AppSnackBar.showSnackBar(in: self?.view, message: error)
                self?.progressHUD.dismiss()
                return
            }
            guard let result = checkResponse?.result else {
                self?.progressHUD.dismiss()
                return
            }
            if result != .free {
                AppSnackBar.showSnackBar(in: self?.view, message: result.representedValue)
                self?.progressHUD.dismiss()
                return
            }
            self?.registerProfile()
        }
    }
    
    func registerProfile() {
        networkManager.register(username: loginTextField.text ?? "",
                                     password: passwordTextField.text ?? "") { [ weak self ] (tokenResponse, error) in
            self?.progressHUD.dismiss()
            if let error = error?.localizedDescription {
                AppSnackBar.showSnackBar(in: self?.view, message: error)
            } else {
                self?.keycheinStorageManager.saveTokenResponseToKeychein(tokenResponse: tokenResponse)
                self?.transitionToTabBarController()
            }
        }
    }
    
    func transitionToTabBarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: TabBarController.className) as? TabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true, completion: nil)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if inputTextFields.last == textField {
            textField.resignFirstResponder()
            return true
        }
        if let index = inputTextFields.firstIndex (where: {
            inputTextField in
            inputTextField == textField
        }) {
            inputTextFields[index+1].becomeFirstResponder()
        }
        return true
    }
}

extension RegistrationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = scrollView.contentOffset.y
        if topOffset <= 0 {
            let initialTextSize: CGFloat = 36
            let sizeScaling = 1 + (-topOffset / 1000)
            registrationLabel.font = .systemFont(ofSize: initialTextSize * sizeScaling)
        }
    }
}
