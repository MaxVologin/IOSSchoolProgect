//
//  RegistrationViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 16.04.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    var inputTextFields: [UITextField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        settingInputTextFields(textFields: loginTextField, passwordTextField, repeatPasswordTextField)
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
    }
    
    func settingInputTextFields(textFields: UITextField...) {
        for textField in textFields {
            textField.delegate = self
            textField.indent(size: 24)
            inputTextFields.append(textField)
        }
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
