//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by Andres Londono on 25/4/2023.
//

import SwiftUI

// The `RecipeComponent` is inheriting from `CustomStringConvertible` to use its `description` property. Otherwise we will have our own `description` property.
protocol RecipeComponent: CustomStringConvertible {
    init()
    static func SingularName() -> String
    static func PluralName() -> String
}

extension RecipeComponent {
    static func SingularName() -> String {
        String(describing: self).lowercased()
    }
    static func PluralName() -> String {
        self.SingularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            NavigationStack {
                let addComponentView = DestinationView(component: $newComponent)
                { component in
                    components.append(component)
                    newComponent = Component()
                }.navigationTitle("Add \(Component.SingularName().capitalized)")
        
                if components.isEmpty {
                    Spacer()
                    NavigationLink("Add the first \(Component.SingularName())",
                                   destination: addComponentView)
                    Spacer()
                } else {
                    HStack {
                        Text(Component.PluralName().capitalized)
                            .font(.title)
                            .padding()
                        Spacer()
                        EditButton()
                            .padding()
                    }
                    List {
                        ForEach(components.indices, id: \.self) { index in
                            let component = components[index]
                            let editComponentView = DestinationView(component: $components[index]) { _ in
                                return
                            }
                                .navigationTitle("Edit \(Component.SingularName().capitalized)")
                            NavigationLink(component.description, destination: editComponentView)
                        }
                        .onDelete { components.remove(atOffsets: $0) }
                        .onMove { indices, newOffset in
                            components.move(fromOffsets: indices, toOffset: newOffset)
                        }
//                            Text(component.description)
//                        }
//                        .listRowBackground(listBackgroundColor)
//                        NavigationLink("Add another \(Component.SingularName())",
//                                       destination: addComponentView)
//                        .buttonStyle(PlainButtonStyle())
//                        .listRowBackground(listBackgroundColor)
                    }.foregroundColor(listTextColor)
                }
            }
        }
    }
}

struct ModifyComponentsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    static var previews: some View {
        ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $emptyIngredients)
    }
}
