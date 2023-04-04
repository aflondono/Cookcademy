//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Andres Londono on 2/4/2023.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    // `RecipesCategoryGridView` will maintain the state of `recipeData`
    // and pass `recipeData` as an environmentObject to the other views.
    // This is useful because if you modify `recipeData` in any view,
    // the environment will let the views know the variable changed.
    
    @StateObject private var recipeData = RecipeData()
    
    var body: some View {
        let columns = [GridItem(), GridItem()]
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(MainInformation.Category.allCases,
                            id: \.self) { category in
                        NavigationLink(
                            destination: RecipesListView(category: category)
                                .environmentObject(recipeData),
                            label: {
                                CategoryView(category: category)
                            })
                    }
                })
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            // `category.rawValue` is the same as the image filename.
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGridView()
    }
}
