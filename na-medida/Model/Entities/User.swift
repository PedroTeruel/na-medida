//
//  User.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import Foundation
import SwiftData

@Model
final class User{
    var username: String = ""
    var alreadySawOnBoard: Bool = false

    init(username: String) {
        self.username = username
    }
}
