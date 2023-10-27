//
//  OnboardingInformation.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/26/23.
//

import SwiftUI

struct OnboardingInformation: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String

    var body: some View {
        VStack(spacing: 20) {
            Image("littleLemonLogoHero")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: .infinity, maxHeight: 200)
                   .padding()
            Text("Sign Up")
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.primary1)
            
            VStack(alignment: .leading, spacing: 8){
                Text("First Name*")
                TextField("First Name", text: $firstName)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Last Name*")
                TextField("First Name", text: $lastName)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Email*")
                TextField("First Name", text: $email)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)

        }
        .padding()
    }
}

#Preview {
    OnboardingInformation(firstName: .constant(""), lastName: .constant(""), email: .constant(""))
}
