//
//  OnboardingIntro.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/26/23.
//

import SwiftUI

struct OnboardingIntro: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("littleLemonLogoHero")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: .infinity, maxHeight: 200)
                   .padding()
            Text("Welcome To Little Lemon Demo Application")
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.primary1)
            
            Text("This app is part of the Coursera Meta iOS Developer Certification Capstone Project. It showcases our skills and knowledge gained throughout the certification program.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary4)
            
            Text("Please press Next to continue with the onboarding.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary4)

        }
        .padding()
    }
}

#Preview {
    OnboardingIntro()
}
