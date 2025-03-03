//
//  ContentView.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            TabView {
                OnboardingScreen(title: "Your Personal Stylist", description: "who matches you perfectly", imageName: "image1")
                    .tag(0)
                OnboardingScreen(title: "Curated outfits", description: "of high quality and multiple brands", imageName: "image2")
                    .tag(1)
                OnboardingScreen(title: "Weekly Outfit Selections", description: "hand-picked by your stylist", imageName: "image3")
                    .tag(2)
            }
            .padding(.top, 16)
            .background(Color.white)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            VStack{
                ReusableButton(
                    text: "Take a Quiz",
                    action: {
                        store.dispatch(action: .quiz(action: .startQuiz))
                    },
                    foregroundColor: .white,
                    backgroundColor: .black,
                    size: 16,
                    cornerRadius: 0
                )
                TermsTextView()
            }
        }.padding()
        .background(Color.white)
    }
}

struct TermsTextView: View {
    var body: some View {
        Text(makeAttributedString())
            .font(.footnote)
            .multilineTextAlignment(.center)
            .onOpenURL { url in
                if url.absoluteString == "terms://use" {
                    print("Terms of Use tapped")
                } else if url.absoluteString == "privacy://policy" {
                    print("Privacy Policy tapped")
                }
            }
    }
    
    private func makeAttributedString() -> AttributedString {
        var result = AttributedString("By tapping Get started or I already have an account, you agree to our ")
        result.foregroundColor = .gray
        
        var terms = AttributedString("Terms of Use")
        terms.foregroundColor = .black
        terms.underlineStyle = .single
        terms.link = URL(string: "terms://use")
        
        var andText = AttributedString(" and ")
        andText.foregroundColor = .gray
        
        var privacy = AttributedString("Privacy Policy")
        privacy.foregroundColor = .black
        privacy.underlineStyle = .single
        privacy.link = URL(string: "privacy://policy")
        
        var period = AttributedString(".")
        period.foregroundColor = .gray
        
        result.append(terms)
        result.append(andText)
        result.append(privacy)
        result.append(period)
        
        return result
    }
}

struct TermsTextView_Previews: PreviewProvider {
    static var previews: some View {
        TermsTextView()
            .previewLayout(.sizeThatFits)
    }
}

struct OnboardingScreen: View {
    let title: String
    let description: String
    let imageName: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("KaiseiTokumin-Bold", size: 28))
                .foregroundColor(.black)
                .lineSpacing(12)
                .kerning(0)
                .lineLimit(0)
            Text(description)
                .font(.custom("KaiseiTokumin-Medium", size: 20))
                .foregroundColor(.black)
                .lineSpacing(12)
                .kerning(0)
                .lineLimit(0)
            Spacer()
            Image(imageName)
            Spacer()
        }
        .background(Color.white)
    }
}
