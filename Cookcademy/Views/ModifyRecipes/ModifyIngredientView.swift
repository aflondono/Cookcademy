//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Andres Londono on 25/4/2023.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    // Because the `ModifyIngredientView` gets its ingredient from a different
    // view, update its ingredient to be a `@Binding` instead of a `@State`
    // property.
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    // When defining the initializer, init(component:createAction:),
    // we’ll want to be able to assign a value to the ingredient property
    // marked with the @Binding property wrapper. We can do that by adding a leading underscore.
    // self._ingredient is of type Binding<Ingredient> and can be assigned
    // to the binding passed into the initializer.
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    //@Environment(\.presentationMode) private var mode
    // The line above, in the tutorial, is deprecated. Use the one below:
    @Environment(\.dismiss) private var dismiss
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Ingredient Name", text: $ingredient.name)
                .listRowBackground(listBackgroundColor)
            Stepper(value: $ingredient.quantity, in: 0...1000, step: 0.5) {
                HStack {
                    Text("Quantity:")
                    TextField("Quantity",
                              value: $ingredient.quantity,
                              format: .number)
//                                  formatter: NumberFormatter.decimal)
                    .keyboardType(.numbersAndPunctuation)
                }
            }.listRowBackground(listBackgroundColor)
            Picker("Units", selection: $ingredient.unit) {
                ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            }.listRowBackground(listBackgroundColor)
// The code below is what was on the tutorial, but it doesn't seem correct:
//                Picker(selection: $ingredient.unit, label:
//                        HStack {
//                    Text("Unit")
//                    Spacer()
//                    Text(ingredient.unit.rawValue)
//                }, content: {
//                    ForEach(Ingredient.Unit.allCases, id: \.self, content: { unit in
//                        Text(unit.rawValue)
//                    })
//                })
            HStack {
                Spacer()
                Button("Save") {
                    createAction(ingredient)
                    dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
    }
}

// Instead of using `TextField(_:value:formatter:)` and needing this extension,
// use `TextField(_:value:format:)`
//extension NumberFormatter {
//  static var decimal: NumberFormatter {
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .decimal
//    return formatter
//  }
//}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var emptyIngredient = Ingredient()
    
    static var previews: some View {
        ModifyIngredientView(component: $emptyIngredient) { ingredient in
            print(ingredient)
        }
    }
}
