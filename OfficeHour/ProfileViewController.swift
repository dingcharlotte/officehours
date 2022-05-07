//
//  ProfileViewController.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let usernameField = UITextField()
    let nameField = UITextField()
    let bioField = UITextField()
    let subjectsField = UITextField()
    let priceField = UITextField()
    let availableButton = UIButton()
    let saveEditsButton = UIButton()
    let deleteAccountButton = UIButton()
    
    var isAvailable = true
    var person: Person = Person(id: -1, username: "", name: "", bio: "", price: nil, isAvailable: false, subjects: [], sentRequests: [], receivedRequests: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Profile"
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        NetworkManager.getUser(id: User.instance.id) { [weak self] person in
            guard let self = self else { return }
            self.update(person: person)
        }
        
        usernameField.textColor = .darkGray
        usernameField.font = .systemFont(ofSize: 18)
        usernameField.borderStyle = .bezel
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameField)
                
        nameField.textColor = .black
        nameField.font = .systemFont(ofSize: 20)
        nameField.borderStyle = .bezel
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        bioField.textColor = .darkGray
        bioField.font = .systemFont(ofSize: 18)
        bioField.borderStyle = .bezel
        bioField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bioField)

        subjectsField.textColor = .darkGray
        subjectsField.font = .systemFont(ofSize: 18)
        subjectsField.borderStyle = .bezel
        subjectsField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subjectsField)

        priceField.textColor = .black
        priceField.font = .systemFont(ofSize: 20)
        priceField.borderStyle = .bezel
        priceField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceField)

        availableButton.setTitle("  Currently Unavailable  ", for: .normal)
        availableButton.setTitleColor(.systemRed, for: .normal)
        availableButton.layer.borderWidth = 2
        availableButton.layer.borderColor = UIColor.systemRed.cgColor
        availableButton.layer.cornerRadius = 10
        availableButton.addTarget(self, action: #selector(availableButtonTapped), for: .touchUpInside)
        availableButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(availableButton)
        
        saveEditsButton.setTitle("  Save edits  ", for: .normal)
        saveEditsButton.setTitleColor(.systemBlue, for: .normal)
        saveEditsButton.addTarget(self, action: #selector(saveEdits), for: .touchUpInside)
        saveEditsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveEditsButton)
        
        deleteAccountButton.setTitle("  Delete Account  ", for: .normal)
        deleteAccountButton.setTitleColor(.systemRed, for: .normal)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteAccountButton)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 20
        
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        bioField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        subjectsField.snp.makeConstraints { make in
            make.top.equalTo(bioField.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        priceField.snp.makeConstraints { make in
            make.top.equalTo(subjectsField.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
            
        availableButton.snp.makeConstraints { make in
            make.top.equalTo(priceField.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        saveEditsButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalTo(view.snp.centerX).offset(-padding/2)
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.leading.equalTo(view.snp.centerX).offset(padding/2)
            make.trailing.equalToSuperview().offset(-padding)
        }
    }
    
    @objc func availableButtonTapped() {
        if !isAvailable {
            isAvailable = true
            availableButton.setTitle("  Currently Available  ", for: .normal)
            availableButton.setTitleColor(.systemGreen, for: .normal)
            availableButton.layer.borderColor = UIColor.systemGreen.cgColor
            saveEdits()
        } else {
            isAvailable = false
            availableButton.setTitle("  Currently Unavailable  ", for: .normal)
            availableButton.setTitleColor(.systemRed, for: .normal)
            availableButton.layer.borderColor = UIColor.systemRed.cgColor
            saveEdits()
        }
    }
    
    @objc func saveEdits() {
        let username = usernameField.text ?? ""
        let name = nameField.text ?? ""
        let bio = bioField.text ?? ""
        let subjects = arrayify(str: subjectsField.text ?? "")
        let price = Int(priceField.text ?? "0") ?? 0
        
        NetworkManager.editUser(id: User.instance.id, username: username, name: name, bio: bio, price: price, subjects: subjects, isAvailable: isAvailable) {  [weak self] person in
            guard let self = self else { return }
            self.update(person: person)
        }
    }
    
    @objc func deleteAccount() {
        // MARK: use deleteUser
        // NetworkManager.deleteUser
        print("deleting user")
        NetworkManager.deleteUser(id: User.instance.id) { [weak self] person in
            User.instance.id = -1 // TODO ??
        }
    }

    private func update(person: Person) {
        self.person = person
        usernameField.text = person.username
        nameField.text = person.name
        bioField.text = person.bio
        //subjectsField.text = person.subjects?.lazy.joined(separator: ", ")
        priceField.text = "\(person.price!)"
    }
    
    private func arrayify(str: String) -> [String] {
        let components = str.uppercased().components(separatedBy: ", ")
        return components
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
