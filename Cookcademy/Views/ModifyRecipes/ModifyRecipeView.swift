//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Andres Londono on 4/4/2023.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        Button("Fill in the recipe with test data.") {
            recipe.mainInformation = MainInformation(name: "test name", description: "test description", author: "test author", category: .breakfast)
            recipe.directions = [Direction(description: "first do this", isOptional: false), Direction(description: "then do that", isOptional: true)]
            recipe.ingredients = [Ingredient(name: "test ingredient 1", quantity: 2, unit: .cups), Ingredient(name: "test ingredient 2", quantity: 1, unit: .g)]
        }
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
