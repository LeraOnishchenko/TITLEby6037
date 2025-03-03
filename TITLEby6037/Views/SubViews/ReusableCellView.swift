import SwiftUI

struct ReusableCellView: View {
    let height: CGFloat
    let mainText: String?
    let text: String?
    let systemImageName: String?
    let color: String?
    let isSelected: Bool
    let numberOfColumns: Int
    let onTapGesture: (() -> ())?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                if let urlString = systemImageName, let url = URL(string: urlString) {
                    VStack(spacing: 8) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        Text(mainText?.uppercased() ?? "")
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(.black)
                    }.frame(width: height, height: height)
                }
                else if let colorHex = color, let actualColor = Color(hex: colorHex) {
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(actualColor)
                            .frame(width: 30, height: 30)
                        Text(mainText?.uppercased() ?? "")
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(.black)
                    }.frame(width: height, height: height)
                }
                else if let text = text {
                    VStack(alignment: .leading) {
                        Text(mainText?.uppercased() ?? "")
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(text.lowercased())
                            .font(.custom("Poppins-Regular", size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(width: height)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(isSelected ? Color.black : Color.gray, lineWidth: 1)
                    .frame(width: height, height: text != nil ? nil : height)
            )
            ZStack {
                if isSelected {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 24, height: 24)
                        .cornerRadius(0)
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold))
                } else if color == nil {
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 24, height: 24)
                        .cornerRadius(0)
                }
            }.modifier(CheckmarkPositionModifier(columns: numberOfColumns))
        }
        .onTapGesture {
            if let onTapGesture {
                onTapGesture()
            }
        }
    }
}

struct CheckmarkPositionModifier: ViewModifier {
    let columns: Int

    func body(content: Content) -> some View {
        if columns > 1 {
            return AnyView(
                VStack {
                    HStack {
                        Spacer()
                        content
                    }
                    Spacer()
                }
                .padding(.top, 5)
                .padding(.trailing, 5)
            )
        } else {
            return AnyView(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        content
                    }
                    Spacer()
                }
                .padding(.trailing, 10)
            )
        }
    }
}
