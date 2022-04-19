//
//  RegistrationViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 16.04.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    var inputTextFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 200, right: 0)

        settingInputTextFields(textFields: loginTextField, passwordTextField, repeatPasswordTextField)
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self)
        }
    
    func settingInputTextFields(textFields: UITextField...) {
        for textField in textFields {
            textField.delegate = self
            textField.indent(size: 24)
            inputTextFields.append(textField)
        }
    }
    
    @objc func keyboardDidChange(sender: Notification) {
        guard let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        scrollView.contentInset = .init(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc func keyboardDidHide() {
        scrollView.contentInset = .zero
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
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
    
}
