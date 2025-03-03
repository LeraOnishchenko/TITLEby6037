//
//  ReusableButton.swift
//  TITLEby6037
//
//  Created by lera on 03.03.2025.
//

import SwiftUI

struct ReusableButton: View {
    let text: String
    let action: () -> Void
    let foregroundColor: Color
    let backgroundColor: Color
    let size: Int
    let cornerRadius: CGFloat
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom("Poppins-Regular", size: CGFloat(size)))
                .foregroundColor(foregroundColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}

struct ReusableButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ReusableButton(
                text: "CONTINUE",
                action: { print("Continue tapped") },
                foregroundColor: .white,
                backgroundColor: .black,
                size: 24,
                cornerRadius: 0
            )
            ReusableButton(
                text: "NEXT",
                action: { print("Next tapped") },
                foregroundColor: .blue,
                backgroundColor: .yellow,
                size: 24,
                cornerRadius: 10
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
