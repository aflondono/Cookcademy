//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Andres Londono on 25/4/2023.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        let addIngredientView = ModifyIngredientView(ingredient: $newIngredient)
        { ingredient in
            ingredients.append(ingredient)
            newIngredient = Ingredient()
        }.navigationTitle("Add Ingredient")
        
        NavigationStack {
            VStack {
                if ingredients.isEmpty {
                    Spacer()
                    NavigationLink("Add the first ingredient",
                                   destination: addIngredientView)
                    Spacer()
                } else {
                    List {
                        ForEach(ingredients.indices, id: \.self) { index in
                            let ingredient = ingredients[index]
                            Text(ingredient.description)
                        }
                        .listRowBackground(listBackgroundColor)
                        NavigationLink("Add another ingredient",
                                       destination: addIngredientView)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(listBackgroundColor)
                    }.foregroundColor(listTextColor)
                }
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    static var previews: some View {
        ModifyIngredientsView(ingredients: $emptyIngredients)
    }
}
