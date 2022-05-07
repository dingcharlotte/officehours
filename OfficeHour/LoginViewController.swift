//
//  LoginViewController.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/6/22.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let usernameLabel = UILabel()
    let usernameField = UITextField()
    let passwordLabel = UILabel()
    let passwordField = UITextField()
    let loginButton = UIButton()
    
//    lazy var background: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "gradient"))
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        titleLabel.text = "Login to OfficeHours"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        usernameLabel.text = "Username:"
        usernameLabel.textColor = .black
        usernameLabel.font = .systemFont(ofSize: 18)
        usernameLabel.textAlignment = .left
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
        
        usernameField.textColor = .black
        usernameLabel.font = .systemFont(ofSize: 18)
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        usernameField.spellCheckingType = .no
        usernameField.borderStyle = .bezel
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameField)
        
        passwordLabel.text = "Password:"
        passwordLabel.textColor = .black
        passwordLabel.font = .systemFont(ofSize: 18)
        passwordLabel.textAlignment = .left
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        passwordField.textColor = .black
        passwordField.font = .systemFont(ofSize: 18)
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.spellCheckingType = .no
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .bezel
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordField)
        
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.setTitleColor(.systemBlue, for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 20
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(40)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp_bottomMargin).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp_bottomMargin).offset(40)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
        }
    }
    
    @objc func login() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        NetworkManager.login(username: username, password: password) { [weak self] response in
            guard let self = self else { return }
            User.instance.id = response.userId
            self.dismiss(animated: true)
        }
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
