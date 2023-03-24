//
//  Recipe.swift
//  Cookcademy
//
//  Created by Andres Londono on 24/3/2023.
//

import Foundation

struct Recipe {
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    
    init(mainInformation: MainInformation, ingredients: [Ingredient], directions: [Direction]) {
        self.mainInformation = mainInformation
        self.ingredients = ingredients
        self.directions = directions
    }
    
    init() {
        self.init(mainInformation: MainInformation(name: "", description: "", author: "", category: .breakfast), ingredients: [], directions: [])
    }
}

struct MainInformation {
    var name: String
    var description: String
    var author: String
    var category: Category
    
    enum Category: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}

struct Ingredient {
    var name: String
    var quantity: Double
    var unit: Unit
    
    var description: String {
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name : "\(name)s"
            return "\(formattedQuantity) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) \(name)"
            } else {
                return "\(formattedQuantity) \(unit.rawValue) \(name)"
            }
        }
    }
    
    enum Unit: String, CaseIterable {
        case ml = "Millilitres"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case oz = "Ounces"
        case none = "No units"
        
        var singularName: String {
            String(rawValue.dropLast())
        }
    }
}

struct Direction {
    var description: String
    var isOptional: Bool
}
