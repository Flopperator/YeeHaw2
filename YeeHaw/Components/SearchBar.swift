

import SwiftUI
import Foundation

struct SearchBar: View {
    @Binding var value: String
    @State var isSearching = false
    
    
    var body: some View {
        HStack{
            TextField("Search users", text:$value)
                .padding(.leading,24)
        }.padding()
            .background(Color(.systemGray5))
            .cornerRadius(6.0)
            .padding(.horizontal, -10)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    Button(action: {value = ""}){
                        Image(systemName: "xmark.circle.fill")
                    }
                }.padding(.horizontal, 6)
                    .foregroundColor(.gray)
            )
    }
}
