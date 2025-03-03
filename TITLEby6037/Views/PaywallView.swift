//
//  Untitled.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var store: AppStore
    @State private var selectedPaymentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Image("stylist-image")
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            VStack(spacing: 5) {
                Spacer()
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: index < 5 ? "star.fill" : "star")
                            .foregroundColor(Color(red: 241/255, green: 154/255, blue: 55/255))
                            .padding(.horizontal, 2)
                    }
                }
                Text("FIRST MEETING WITH A STYLIST")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Text("Tesso caught my style with the first outfit she put together. Although we changed a few things she was great at finding what works for me!")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Spacer()
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 23)
                                .overlay(
                                    Text("HOT DEAL 🔥 ")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .bold))
                                )
                            PaymentOptionView(
                                title: "TRY 3 DAYS FOR FREE",
                                price: "",
                                description: "then $29.99 billed monthly",
                                isSelected: selectedPaymentIndex == 0
                            )
                            .onTapGesture {
                                selectedPaymentIndex = 0
                            }
                        }
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 23)
                            PaymentOptionView(
                                title: "Quarterly",
                                price: "$59.99",
                                description: "billed quarterly",
                                isSelected: selectedPaymentIndex == 1
                            )
                            .onTapGesture {
                                selectedPaymentIndex = 1
                            }
                        }
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 23)
                            PaymentOptionView(
                                title: "Lifetime",
                                price: "$99.99",
                                description: "one-time payment",
                                isSelected: selectedPaymentIndex == 2
                            )
                            .onTapGesture {
                                selectedPaymentIndex = 2
                            }
                        }
                    }
                    Spacer()
                    Text("Auto-renewable. Cancel anytime.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    ReusableButton(
                        text: "CONTINUE",
                        action: {
                            store.dispatch(action: .goToNextScreen)
                        },
                        foregroundColor: .white,
                        backgroundColor: .black,
                        size: 14,
                        cornerRadius: 0
                    )
                }
                VStack {
                    HStack {
                        Text("Terms of Use")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text("|")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text("Privacy Policy")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }.padding()
        }
        .ignoresSafeArea(.container, edges: .top)
        .background(Color.white)
    }
}

struct PaymentOptionView: View {
    let title: String
    let price: String
    let description: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            Text(price)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(.black)
            Spacer()
            Text(description)
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(isSelected ? Color.black : Color.gray, lineWidth: 1)
        )
    }
}
