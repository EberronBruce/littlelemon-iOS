//
//  AppState.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/25/23.
//

import Foundation
import SwiftUI

let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "kIsLoggedIn"

// Optional: Email validation function
func isValidEmail(_ email: String) -> Bool {
    let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}

