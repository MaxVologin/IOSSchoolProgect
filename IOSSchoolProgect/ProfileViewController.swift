//
//  UserLoginViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 25.04.2022.
//

import UIKit
import EFColorPicker

class ProfileViewController: UIViewController {
    
    let networkManager: ProfileNetworkManager = NetworkManager()
    let storageManager = StorageManager()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var tintBackImageView: UIView!
    @IBOutlet var tapGestureRecognizerForPhotoImageView: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tapGestureRecognizerForPhotoImageView.addTarget(self, action: #selector(alertImage))
        tableView.dataSource = self
        registerCells()
        changeTintBackImage()
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
    
    func profileUsername(completion: @escaping (String?)->()) {
        guard let userId = storageManager.loadTokenResponseFromKeychein()?.userId else { return }
        networkManager.profile(userId: userId) { (profile, error) in
            if let error = error {
                print(error)
            } else {
                completion(profile?.username)
            }
        }
    }
    
    func changeTintBackImage() {
        tintBackImageView.alpha = 0.51
        if let colorHex = storageManager.loadColorProfileFromUserDefaults(key: .profileColor) {
            tintBackImageView.backgroundColor = UIColor(hexForProfileColor: colorHex)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: UserLoginTableViewCell.className) as? UserLoginTableViewCell {
            profileUsername(completion: { (username) in
                cell.usernameLabel.text = username
            })
            return cell
        }
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationDateTableViewCell.className) as? RegistrationDateTableViewCell {
            return cell
        }
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfileColorTableViewCell.className) as? ProfileColorTableViewCell {
            cell.colorChoiseButton.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
            if let colorHex = storageManager.loadColorProfileFromUserDefaults(key: .profileColor) {
                cell.colorChoiseButton.backgroundColor = UIColor(hexForProfileColor: colorHex)
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        setupProfileImages(image: profileImage)
        dismiss(animated: true, completion: nil)
    }
    
    func setupProfileImages(image: UIImage?) {
        profileImageView.image = image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.frame = .init(x: 5, y: 5, width: 164, height: 164)
        profileImageView.layer.cornerRadius = 82
        changeTintBackImage()
        backImageView.image = image
    }
}

extension ProfileViewController: EFColorSelectionViewControllerDelegate {
    func colorViewController(_ colorViewCntroller: EFColorSelectionViewController, didChangeColor color: UIColor) {
        storageManager.saveColorProfiletoUserDefaults(colorProfileHEX: color.toHexString(), key: .profileColor)
        changeTintBackImage()
        tableView.reloadData()
    }
    
    @objc func openColorPicker() {
        let colorSelectionController = EFColorSelectionViewController()
        let navigationController = UINavigationController(rootViewController: colorSelectionController)
        navigationController.navigationBar.backgroundColor = view.backgroundColor
        colorSelectionController.view.backgroundColor = view.backgroundColor
        colorSelectionController.delegate = self
        if let colorProfile = storageManager.loadColorProfileFromUserDefaults(key: .profileColor) {
            colorSelectionController.color = UIColor(hexForProfileColor: colorProfile) ?? UIColor.white
            print(colorProfile)
        }
        colorSelectionController.setMode(mode: .rgb)

        if UIUserInterfaceSizeClass.compact == self.traitCollection.horizontalSizeClass {
            let doneButton: UIBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString("Done", comment: ""),
                style: UIBarButtonItem.Style.done,
                target: self,
                action: #selector(dismissViewController)
            )
            colorSelectionController.navigationItem.rightBarButtonItem = doneButton
        }
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
