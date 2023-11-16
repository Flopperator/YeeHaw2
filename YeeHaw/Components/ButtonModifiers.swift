

import SwiftUI

struct ButtonModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(width: 300)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .black))
            .background(Color.color0)
            .cornerRadius(8.0)
    }
}
    struct ButtonModifiers0: ViewModifier {
        func body(content: Content) -> some View {
            content.frame(width: 322)
                .frame(height: 5)
                .padding()
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .black))
                .background(Color.color4)
                .cornerRadius(8.0)
        
    }
    
    
    
}
