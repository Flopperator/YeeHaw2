//
//  FormField.swift
//  YeeHaw
//
//  Created by Quade Witt on 11/5/23.

//Makes a reusable text field

import SwiftUI

struct FormField: View {
    //property wrapper binding two way connection between a property that stores data and the view that displays it
    @Binding var value: String
    var icon: String
    var placeholder: String
    var isSecure = false
    
    
    
    
    var body: some View {
        Group{
            HStack{
                Image(systemName: icon).padding()
                
                Group{
                    if isSecure{
                        //$ denotes we are getting the Binding<Bool> value instead of the Bool associated with isSecure
                        SecureField(placeholder, text: $value)
                        
                    } else {
                        TextField(placeholder, text: $value)
                    }
                }.font(Font.system(size: 20, design: .monospaced))
                    .foregroundColor(.secondary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
            }.overlay(RoundedRectangle(cornerRadius:
                                        8).stroke(Color.secondary, lineWidth: 4)).padding()
        }
    }
}

