//
//  UserLoginViewController.swift
//  IOSSchoolProgect
//
//  Created by maxvologin on 25.04.2022.
//

import UIKit
import EFColorPicker

class ProfileViewController: UIViewController {
    
    let networkManager = ServiceLocator.profileNetworkManager()
    let storageManager = ServiceLocator.storageManager()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var tintBackImageView: UIView!
    @IBOutlet var tapGestureRecognizerForPhotoImageView: UITapGestureRecognizer!
    
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tapGestureRecognizerForPhotoImageView.addTarget(self, action: #selector(alertImage))
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        changeTintBackImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestProfile()
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
    
    func requestProfile() {
        guard let userId = storageManager.token()?.userId else { return }
        networkManager.profile(userId: userId) { [ weak self ] (profile, error) in
            if let error = error {
                AppSnackBar.showSnackBar(in: self?.view, message: error.localizedDescription)
            } else {
                self?.profile = profile
                self?.tableView.reloadData()
            }
        }
    }
    
    func changeTintBackImage() {
        tintBackImageView.alpha = 0.51
        if let colorHex = storageManager.colorProfile() {
            tintBackImageView.backgroundColor = UIColor(hex: colorHex)
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
            if let name = profile?.username {
                cell.usernameLabel.text = name
            }
            return cell
        }
        if indexPath.row == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationDateTableViewCell.className) as? RegistrationDateTableViewCell {
            return cell.configure(profile: profile)
        }
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: ProfileColorTableViewCell.className) as? ProfileColorTableViewCell {
            if let colorHex = storageManager.colorProfile() {
                cell.colorChoiseLabel.backgroundColor = UIColor(hex: colorHex)
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            openColorPicker()
        }
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
        storageManager.saveColorProfile(colorProfileHEX: color.toHexString())
        changeTintBackImage()
        tableView.reloadData()
    }
    
    func openColorPicker() {
        let colorSelectionController = EFColorSelectionViewController()
        let navigationController = UINavigationController(rootViewController: colorSelectionController)
        navigationController.navigationBar.backgroundColor = view.backgroundColor
        colorSelectionController.view.backgroundColor = view.backgroundColor
        colorSelectionController.delegate = self
        if let colorProfile = storageManager.colorProfile() {
            colorSelectionController.color = UIColor(hex: colorProfile) ?? .white
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
