//
//  ViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 06.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    var inputTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        inputTextFields = [loginTextField, passwordTextField]
        
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
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
