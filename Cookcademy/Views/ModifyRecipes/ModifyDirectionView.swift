//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Andres Londono on 29/5/2023.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        // When defining the initializer, init(component:createAction:),
        // we’ll want to be able to assign a value to the direction property
        // marked with the @Binding property wrapper. We can do that by adding a leading underscore.
        // self._direction is of type Binding<Direction> and can be assigned
        // to the binding passed into the initializer.
        self._direction = component
        self.createAction = createAction
    }
    
    //@Environment(\.presentationMode) private var mode
    // The line above, in the tutorial, is deprecated. Use the one below:
    @Environment(\.dismiss) private var dismiss
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    //mode.wrappedValue.dismiss()
                    // The line above was on the tuturial but it doesn't compile. Using instead the line below:
                    dismiss()
                }
                Spacer()
            }
            .listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
        ModifyDirectionView(component: $emptyDirection) { _ in return
        }
    }
}
