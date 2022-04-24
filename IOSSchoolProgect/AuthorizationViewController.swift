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
        scrollView.delegate = self
        settingInputTextFields(textFields: loginTextField, passwordTextField)
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
        settingCustomSpacingsInStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    func settingCustomSpacingsInStackView() {
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
                    let textFieldY = textField.frame.origin.y + self.stackView.frame.origin.y
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

extension AuthorizationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = scrollView.contentOffset.y
        if topOffset <= 0 {
            let initialTextSize: CGFloat = 36
            let sizeScaling = 1 + (-topOffset / 1000)
            authorizationLabel.font = .systemFont(ofSize: initialTextSize * sizeScaling)
        }
    }
}
