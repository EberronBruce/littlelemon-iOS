//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/19/23.
//

import SwiftUI

struct Onboarding: View {
    @State private var currentPage = 1
    @EnvironmentObject var appState: AppState
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    var isNextButtonEnabled: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email)
    }
    
    var body: some View {
        NavigationStack { 
            VStack {
                switch (currentPage) {
                case 1:
                    OnboardingIntro()
                case 2:
                    OnboardingInformation(firstName: $firstName, lastName: $lastName, email: $email)
                default:
                    OnboardingExit()
                }
                
                Spacer()
                
                HStack {
                    if currentPage != 1 {
                        Button("Prevous") {
                            if currentPage > 1 {
                                currentPage -= 1
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .disabled(currentPage == 1)
                        .background(Color.primary1)
                        .tint(Color.secondary3)
                        .cornerRadius(8)
                        
                        Spacer()

                    }
                    
                    
                    Button(currentPage == 3 ? "Get Started" : "Next") {
                        if currentPage < 3 {
                            //appState.isLoggedIn = true
                            currentPage += 1
                        } else {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            
                            currentPage = 1
                            appState.isLoggedIn = true
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 50)
                    .background(
                        currentPage == 2 && !isNextButtonEnabled ? Color.secondary3 : Color.primary1
                    )
                    .tint(Color.secondary3)
                    .cornerRadius(8)
                    .disabled(currentPage == 2 && !isNextButtonEnabled)
                    
                }
                .padding()
                .padding(.horizontal, 10)
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    appState.isLoggedIn = true
                }
            }
            .navigationDestination(isPresented: $appState.isLoggedIn) {
                Home()
            }
            
        }
        
        .preferredColorScheme(.light)
    }
}



#Preview {
    Onboarding()
}
