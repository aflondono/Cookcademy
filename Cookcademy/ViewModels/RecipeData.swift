//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Andres Londono on 29/3/2023.
//

import Foundation

// The `RecipeData` class contains a `recipes` property to access recipes.
// `RecipeData` conforms to the `ObservableObject` protocol. The `ObservableObject`
// protocol monitors when the `@Published` property changes. The `@Published`
// property wrapper attaches to a property to monitor any changes. Here, `recipes`
// will monitor when `Recipe.testRecipes` changes. `RecipeData` needs to be a class
// to conform to the `ObservableObject` protocol.
class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        
        return filteredRecipes
    }
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
}
