//
//  Home.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/19/23.
//

import SwiftUI

struct Home: View { 
    @State private var isUserProfileActive = false
    let persistence = PersistenceController.shared
    
    var body: some View {
        
        Menu()
            .environment(\.managedObjectContext, persistence.container.viewContext)
        
            .navigationBarTitle("Menu", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("littleLemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                isUserProfileActive.toggle()
            }) {
                Image("Profile")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            )
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(isPresented: $isUserProfileActive) {
                UserProfile()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
            }
        
        
            .preferredColorScheme(.light)
    }
    
}

#Preview {
    Home()
}
