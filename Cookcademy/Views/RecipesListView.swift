//
//  ContentView.swift
//  Cookcademy
//
//  Created by Andres Londono on 24/3/2023.
//

import SwiftUI

struct RecipesListView: View {
    // `@StateObject` updates the view when the model changes.
    @StateObject var recipeData = RecipeData()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle(navigationTitle)
        }
    }
}

extension RecipesListView {
    var recipes: [Recipe] {
        recipeData.recipes
    }
    
    var navigationTitle: String {
        "All Recipes"
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecipesListView()
        }
    }
}
