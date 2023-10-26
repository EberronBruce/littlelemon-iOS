//
//  CategorySelction.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/25/23.
//

import SwiftUI

struct CategorySelection: View {
    @Binding var selectedCategory: String // Binding to pass the selected category
    
    // Array of categories for the filter buttons
    let categories = ["Starters", "Mains", "Deserts", "Sides"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Order for Delivery")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                Image("van")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 50)
                    .padding()
            }
            
            // Horizontal ScrollView for filter buttons
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack(spacing: 10) {
                     ForEach(categories, id: \.self) { category in
                         Button(action: {
                             // Set the selected category when a filter button is tapped
                             selectedCategory = category.lowercased()
                         }) {
                             Text(category)
                                 .padding(10)
                                 .background(selectedCategory == category ? Color.primary1 : Color.secondary3)
                                 .foregroundColor(selectedCategory == category ? .white : .primary1)
                                 .cornerRadius(20)
                         }
                     }
                 }
             }
             .padding(.bottom, 20)
            
            Divider()

        }
        .padding(.horizontal)
        
    }
}

#Preview {
    CategorySelection(selectedCategory: .constant(""))
}
