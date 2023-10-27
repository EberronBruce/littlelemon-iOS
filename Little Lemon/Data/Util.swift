//
//  Util.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/26/23.
//

import Foundation
import CoreData

let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "kIsLoggedIn"

let menuDataURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"

// Optional: Email validation function
func isValidEmail(_ email: String) -> Bool {
    let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

func getMenuData(viewContext: NSManagedObjectContext) {
    
    if checkIfDishesExist(viewContext: viewContext) { return }
    
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
                    
                    // Convert MenuItems to Dishes and save to the database
                    for menuItem in decodedData.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.desc = menuItem.description
                        dish.category = menuItem.category
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

func checkIfDishesExist(viewContext: NSManagedObjectContext) -> Bool {
    let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()

    do {
        let dishCount = try viewContext.count(for: fetchRequest)
        return dishCount > 0
    } catch {
        print("Error checking for Dish entities: \(error)")
        return false
    }
}
