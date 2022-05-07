//
//  Person.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/1/22.
//

import UIKit

struct PersonArray : Codable {
    let users: [Person]
}

struct Person : Codable {
    let id: Int
    let username: String
    //let password: String
    let name: String
    let bio: String?
    let price: Int?
    let isAvailable: Bool
    let subjects: [Subject]?
    let sentRequests: [Request]?
    let receivedRequests: [Request]?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case bio
        case price
        case isAvailable
        case subjects
        case sentRequests = "sent_transactions"
        case receivedRequests = "received_transactions"
    }
}
