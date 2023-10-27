//
//  OnboardingExit.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/26/23.
//

import SwiftUI

struct OnboardingExit: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("littleLemonLogoHero")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: .infinity, maxHeight: 200)
                   .padding()
            Text("Thank You")
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.primary1)
            
            Text("Thank you for registering up with Little Lemon. We hope to be serving you soon.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary4)
            
            Text("Please press Getting Started to finish.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary4)

        }
        .padding()
    }
}

#Preview {
    OnboardingExit()
}
