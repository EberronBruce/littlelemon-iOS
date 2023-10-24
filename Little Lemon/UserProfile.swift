//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/23/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    // Create constants to hold user information from UserDefaults
    let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @State private var isLogingIn = false
    
    var body: some View {
        VStack(spacing:20) {
            Text("Personal Information")
                .padding()
                .fontWeight(.semibold)
                .font(.largeTitle)
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .padding(.bottom, 20)
            
            Text("First Name: \(firstName)")
                .font(.title3)
            Text("Last Name: \(lastName)")
                .font(.title3)
            Text("Email: \(email)")
                .font(.title3)
            
            Spacer()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 100)
            .background(Color.primary1)
            .tint(Color.secondary3)
            .cornerRadius(8)
            
            Spacer()
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
              isLogingIn = true
            }
        }
    }
}

#Preview {
    UserProfile()
}
