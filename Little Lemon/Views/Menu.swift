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
    //Define the URL for the menu data
    let menuDataURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    
    @State private var menuList: MenuList?
    @State private var searchText = ""
    
    var body: some View {
        VStack() {
            Text("Little Lemon")
            Text("Chicago")
            Text("This is Little Lemon's app to order food")
            
            TextField("Search Menu", text: $searchText)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title ?? "no title") - $\(dish.price ?? "0.0")")
                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .aspectRatio(contentMode: .fit)
                                        
                                } else if phase.error != nil {
                                    // Handle image loading error
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .aspectRatio(contentMode: .fit)

                                } else {
                                    // Placeholder while loading
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                    }
                }
            }
            
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        if checkIfDishesExist() { return }
        
        guard let url = URL(string: menuDataURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // Create a JSONDecoder instance
                let decoder = JSONDecoder()
                
                if let decodedData = try? decoder.decode(MenuList.self, from: data) {
                    DispatchQueue.main.async {
                        self.menuList = decodedData
                        
                        // Convert MenuItems to Dishes and save to the database
                        for menuItem in decodedData.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.image = menuItem.image
                            dish.price = menuItem.price
                            dish.desc = menuItem.description
                        }
                        
                        // Save the data into the database
                        do {
                            try viewContext.save()
                        } catch {
                            print("Error saving to Core Data: \(error)")
                        }
                    }
                } else {
                    print("Failed to decode JSON data.")
                }
            }
        }.resume()
    }
    
    func checkIfDishesExist() -> Bool {
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()

        do {
            let dishCount = try viewContext.count(for: fetchRequest)
            return dishCount > 0
        } catch {
            print("Error checking for Dish entities: \(error)")
            return false
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        return [sortDescriptor]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
}

#Preview {
    Menu()
}

