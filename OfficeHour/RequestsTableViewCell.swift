//
//  RequestsTableViewCell.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/5/22.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let iconImageView = UIImageView()
    //let timestampLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        messageLabel.textColor = .black
        messageLabel.textAlignment = .left
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(messageLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImageView)
    }
    
    func setupConstraints() {
        let iconImageDim: CGFloat = 40
        let topPadding: CGFloat = 20
        let sidePadding: CGFloat = 30

        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            iconImageView.heightAnchor.constraint(equalToConstant: iconImageDim),
            iconImageView.widthAnchor.constraint(equalToConstant: iconImageDim)
        ])
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: sidePadding),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with request: Request) {
        iconImageView.image = UIImage(named: "notifIcon1")
        // TODO: need to fix.
        if request.receiverId == User.instance.id {
            messageLabel.text = "You received a request from \(request.senderName)."
        } else if request.senderId == User.instance.id {
            messageLabel.text = "You sent a request to \(request.receiverName)."
        } else {
            // this request is not relevant to you. idk why you got it.
        }
        // messageLabel.text = "\(request.senderName) (\(request.senderUsername)) has requested you."
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
//        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
//        if let date = dateFormatter.date(from: request.timestamp) {
//            dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
//            timestampLabel.text = "\(dateFormatter.string(from: date)) (EST)"
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
