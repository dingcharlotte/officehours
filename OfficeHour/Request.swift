//
//  Request.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit

struct Request : Codable {
    let id: Int
    let senderId: Int?
    let senderName: String
    let senderUsername: String
    let receiverId: Int?
    let receiverName: String

    enum CodingKeys: String, CodingKey {
        case id
        case senderId = "sender_id"
        case senderName = "sender_name"
        case senderUsername = "sender_username"
        case receiverId = "receiver_id"
        case receiverName = "receiver_name"
    }
}
