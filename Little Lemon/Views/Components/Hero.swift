//
//  Hero.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/25/23.
//

import SwiftUI

struct Hero: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .foregroundStyle(Color.primary2)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Text("Chicago")
                        .foregroundStyle(Color.secondary3)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundStyle(Color.secondary3)
                        .font(.system(size: 16))
                        .padding(.top, 8)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                }
                Image("hero")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 100, maxHeight: 150)
                    .cornerRadius(8)
                    .padding()
                    
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 0)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                    
                    TextField("Search Menu", text: $searchText)
                        .padding(.horizontal, 0)
                        .padding(.leading, 0)
                }
            }
            .frame(height: 40)
         
                
        }
        .padding()
        .background(Color.primary1)
    }
}

#Preview {
    Hero(searchText: .constant(""))
}
