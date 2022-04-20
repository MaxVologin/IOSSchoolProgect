//
//  ViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 06.04.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var authorizationLabel: UILabel!
    @IBOutlet weak var authorizationDescriptionLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    var inputTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingInputTextFields(textFields: loginTextField, passwordTextField)
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
        settingStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    func settingStackView() {
        stackView.setCustomSpacing(26, after: authorizationLabel)
        stackView.setCustomSpacing(76, after: authorizationDescriptionLabel)
    }
    
    func settingInputTextFields(textFields: UITextField...) {
        for textField in textFields {
            textField.delegate = self
            textField.indent(size: 24)
            inputTextFields.append(textField)
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidChange(sender: Notification) {
        guard let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        scrollView.contentInset.bottom = keyboardHeight
    }
    
    @objc func keyboardDidHide() {
        scrollView.contentInset = .zero
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension AuthorizationViewController: UITextFieldDelegate {
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
