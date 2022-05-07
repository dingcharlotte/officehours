//
//  Subject.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/5/22.
//

import UIKit

struct Subjects: Codable {
    let subjects: [Subject]
}

struct Subject : Codable {
    let id: Int
    let name: String
}
