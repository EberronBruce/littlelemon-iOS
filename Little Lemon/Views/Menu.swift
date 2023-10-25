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
    
    var body: some View {
        VStack() {
            Text("Little Lemon")
            Text("Chicago")
            Text("This is Little Lemon's app to order food")
            
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title ?? "no title") - $\(dish.price ?? "0.0")")
                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                } else if phase.error != nil {
                                    // Handle image loading error
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50) // Adjust the size as needed
                                } else {
                                    // Placeholder while loading
                                    ProgressView()
                                        .frame(width: 50, height: 50) // Adjust the size as needed
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
    
}

#Preview {
    Menu()
}

