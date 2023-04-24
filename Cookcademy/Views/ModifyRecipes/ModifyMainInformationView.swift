//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Andres Londono on 24/4/2023.
//

import SwiftUI

struct ModifyMainInformationView: View {
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(listBackgroundColor)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackgroundColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            }
            Picker("Category", selection: $mainInformation.category) {
                ForEach(MainInformation.Category.allCases,
                        id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
// The code below is what was on the tutorial, but it doesn't seem correct:
//            Picker(selection: $mainInformation.category, label:
//                    HStack {
//                Text("Category")
//                Spacer()
//                Text(mainInformation.category.rawValue)
//            }) {
//                ForEach(MainInformation.Category.allCases,
//                        id: \.self) { category in
//                    Text(category.rawValue)
//                }
//            }
//            .pickerStyle(MenuPickerStyle())
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInformation = MainInformation(name: "Test Recipe Name", description: "Test Recipe Description", author: "Test Author Name", category: .breakfast)
    @State static var emptyInformation = MainInformation(name: "", description: "", author: "", category: .breakfast)
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $mainInformation)
        //ModifyMainInformationView(mainInformation: $emptyInformation)
    }
}
