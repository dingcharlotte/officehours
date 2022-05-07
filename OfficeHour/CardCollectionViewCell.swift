//
//  CardCollectionViewCell.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
        
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Send request  ", for: .normal)
        button.setTitleColor(.black, for: . normal)
        // button.setTitleColor(.gray, for: .selected)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(requestTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var person: Person?
    
    private var completion: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10

        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(requestButton)

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for person: Person, completion: @escaping (() -> ())) {
        self.person = person
        self.completion = completion
        nameLabel.text = person.name
        bioLabel.text = person.bio
        priceLabel.text = "$\(person.price!)"
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
       ])
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            bioLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 20),
            priceLabel.bottomAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 50),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            requestButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            requestButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            requestButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    @objc func requestTapped() {
        guard let person = person else { return }
        NetworkManager.createRequest(senderId: User.instance.id,
                                     receiverId: person.id) { [weak self] response in
            // TODO: do something with this request?
            self?.completion?()
        }
    }
}
