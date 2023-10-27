//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/23/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appState: AppState
    
    @Binding var profileImage : Image
    
    // Create constants to hold user information from UserDefaults
    @State var firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Personal Information")
                    .padding()
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .foregroundStyle(Color.primary2)
                
                HStack {
                    VStack {
                        Text("Avatar")
                            .font(.caption)
                            .foregroundStyle(Color.secondary3)
                        profileImage
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                    
                    Button("Change Avatar") {
                        //Show camera or photo album and replace and save image
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color.primary2)
                    .tint(Color.secondary4)
                    .cornerRadius(8)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.primary1)
            
            VStack(alignment: .leading, spacing: 8){
                Text("First Name")
                TextField("First Name", text: $firstName)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Last Name")
                TextField("First Name", text: $lastName)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Email")
                TextField("First Name", text: $email)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
        }
        
       
        
        VStack{
            Button("Save Changes") {
                UserDefaults.standard.set(firstName, forKey: kFirstName)
                UserDefaults.standard.set(lastName, forKey: kLastName)
                UserDefaults.standard.set(email, forKey: kEmail)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 100)
            .background(Color.primary1)
            .tint(Color.secondary3)
            .cornerRadius(8)
            
            Spacer()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                appState.isLoggedIn = false
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 150)
            .background(Color.primary2)
            .tint(Color.secondary4)
            .cornerRadius(8)
            .fontWeight(.bold)
            
        }
        .padding()

    }
}

#Preview {
    UserProfile(profileImage: .constant(Image("Profile")))
}
