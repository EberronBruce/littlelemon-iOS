//
//  Home.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/19/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView() {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    Home()
}
