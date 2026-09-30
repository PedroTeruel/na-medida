//
//  UserRepository.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 30/09/26.
//

import Foundation
import SwiftData

final class UserRepository {
    private let mc: ModelContext

    init(mc: ModelContext) {
        self.mc = mc
    }

    func createUser(username: String) {
        let user = User(username: username)

        mc.insert(user)
    }
}
