//
//  ViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 06.04.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    var inputTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingInputTextFields(textFields: loginTextField, passwordTextField)
        tapGestureRecognizer.addTarget(self, action: #selector(hideKeyboard))
        
        UserDefaults.standard.set(true, forKey: "123")
        UserDefaults.standard.bool(forKey: "123")
        // coreData
        // Realm
        // file
        // keyChain
        
        //менеджеры зависимостей
        // cocoapods самое старое
        // cartage заебешься настривать
        // swiftPackatmanager
    }
    
    func printString(_ string: String) {
        print(string)
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
