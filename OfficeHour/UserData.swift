//
//  UserData.swift
//  OfficeHour
//
//  Created by Charlotte Ding on 5/6/22.
//

import Foundation

class User {
    // to use:
    // User.instance.id = <some value>
    // you can call this singleton anywhere
    static let instance = User()

    var id: Int = 0
}

