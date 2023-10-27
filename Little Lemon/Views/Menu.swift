//
//  Menu.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/19/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil // State to hold the selected category
    
    var body: some View {
        VStack() {
            Hero(searchText: $searchText)
            
            CategorySelection(selectedCategory: $selectedCategory)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        MenuCell(
                            title: dish.title ?? "No title",
                            description: dish.desc ?? "No description",
                            price: dish.price ?? "0.0", imageURL: URL(string: dish.image ?? "") ?? URL(string: "https://example.com/placeholder.jpg")!)
                    }
                }
                .listStyle(.plain)
            }
            
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear {
            getMenuData(viewContext: viewContext)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        return [sortDescriptor]
    }
    
    func buildPredicate() -> NSPredicate {
        var predicates = [NSPredicate]()
        
        if let selectedCategory = selectedCategory {
            // Add category filter
            predicates.append(NSPredicate(format: "category == %@", selectedCategory))
        }
        
        if !searchText.isEmpty {
            // Add search text filter
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        // Combine predicates with 'AND' operator
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    
}

//#Preview {
//    Menu()
//}

