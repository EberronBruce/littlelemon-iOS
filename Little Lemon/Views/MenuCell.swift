//
//  MenuCell.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/25/23.
//

import SwiftUI

struct MenuCell: View {
    let title: String
    let description: String
    let price: String
    let imageURL: URL
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text(description)
                    .lineLimit(2)
                    .font(.system(size: 16))
                Text("$\(String(format: "%.2f", Double(price) ?? 0.0))")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            AsyncImage(url: imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                } else if phase.error != nil {
                    // Handle image loading error
                    Image(systemName: "fork.knife")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .background(Color.primary2)
                        .cornerRadius(8)
                } else {
                    // Placeholder while loading
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .background(Color.secondary3)
                        .cornerRadius(8)
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    MenuCell(title: "Greek Salad", description: "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.", price: "10", imageURL: URL(string: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true")!)
}
