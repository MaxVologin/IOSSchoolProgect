//
//  UserLoginViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 25.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet var tapGestureRecognizerForPhotoImageView: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tapGestureRecognizerForPhotoImageView.addTarget(self, action: #selector(alertImage))
        tableView.dataSource = self
        registerCells()
    }
    
    @objc func alertImage() {
        let alert = UIAlertController(title: nil, message: "Хотите выбрать новое изображение", preferredStyle: .alert)
        let photo = UIAlertAction(title: "Выбрать", style: .default) {_ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(photo)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerCells() {
        registerCell(identifire: UserLoginTableViewCell.className)
        registerCell(identifire: RegistrationDateTableViewCell.className)
        registerCell(identifire: ProfileColorTableViewCell.className)
    }
    
    func registerCell(identifire: String) {
        let nib = UINib(nibName: identifire, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifire)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: UserLoginTableViewCell.className) as? UserLoginTableViewCell {
            return cell
        }
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationDateTableViewCell.className) as? RegistrationDateTableViewCell {
            return cell
        }
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfileColorTableViewCell.className) as? ProfileColorTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.frame = .init(x: 5, y: 5, width: 164, height: 164)
        photoImageView.layer.cornerRadius = 82
        dismiss(animated: true, completion: nil)
    }
}
