//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/19/23.
//

import SwiftUI

let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @EnvironmentObject var appState: AppState
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack { //Change NavigationView to Stack to remove warning
            VStack(spacing: 20) {
                Image("littleLemonLogoHero")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .padding()
                
                Text("Please Register")
                    .font(.system(size: 20))
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Button("Register") {
                    
                    if !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        appState.isLoggedIn = true
                        
                    } else {
                        // Handle invalid input or show an alert to the user
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 100)
                .background(Color.primary1)
                .tint(Color.secondary3)
                .cornerRadius(8)
            }
            .padding()
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $appState.isLoggedIn) { Home() } // Add this instead of NavigationLink to remove warning
            
        }
        .preferredColorScheme(.light)
    }
    
    // Optional: Email validation function
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
