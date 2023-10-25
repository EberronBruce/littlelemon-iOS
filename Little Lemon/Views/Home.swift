//
//  Home.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/19/23.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        NavigationView {
            TabView() {
                Menu()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                UserProfile()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("littleLemonLogo") // Replace "photo" with the name of your image
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    // Add your action when the button is tapped
                }) {
                    Image(systemName: "plus") // Replace "plus" with the name of your image
                        .font(.title)
                        .foregroundColor(.blue) // Customize the image color
                }
            )
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }

    }
}

#Preview {
    Home()
}
