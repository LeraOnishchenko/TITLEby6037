//
//  IntroScreenView.swift
//  TITLEby6037
//
//  Created by lera on 03.03.2025.
//

import SwiftUI

struct IntroScreenView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            Spacer()
            Text("Online Personal\nStyling.\nOutfits for\nEvery Woman.")
                .font(.custom("KaiseiTokumin-Regular", size: 32))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            ReusableButton(
                text: "CONTINUE",
                action: {
                    store.dispatch(action: .goToNextScreen)
                },
                foregroundColor: .black,
                backgroundColor: .white,
                size: 14,
                cornerRadius: 0
            )
            .padding(.bottom, 40)
        }.padding()
            .background(
                ZStack {
                    Image("introImage")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
            )
    }
}
