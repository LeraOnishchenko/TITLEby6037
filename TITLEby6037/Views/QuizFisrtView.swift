import SwiftUI

struct QuizView: View {
    @EnvironmentObject var store: AppStore
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        let quizState = store.state.quizState
        let currentQuestion = quizState.questions[quizState.currentQuestionIndex]
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(currentQuestion.text)
                    .font(.custom("KaiseiTokumin-Medium", size: 26))
                    .foregroundColor(.black)
                    .kerning(0)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                if let text = currentQuestion.subText{
                    Text(text)
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(.black)
                        .kerning(0)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                GeometryReader { geometry in
                    if geometry.size != .zero {
                        var size = geometry.size
                        let spacing: CGFloat = 10
                        let columnsCount = CGFloat(currentQuestion.numberOfColumns)
                        let totalSpacing = spacing * (columnsCount - 1)
                        let cellWidth = (geometry.size.width - totalSpacing) / columnsCount
                        
                        ScrollView {
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.fixed(cellWidth), spacing: spacing), count: currentQuestion.numberOfColumns),
                                spacing: spacing
                            ) {
                                ForEach(currentQuestion.options, id: \.id) { answ in
                                    ReusableCellView(
                                        height: cellWidth,
                                        mainText: answ.text,
                                        text: answ.subText,
                                        systemImageName: answ.image,
                                        color: answ.color,
                                        isSelected: quizState.selectedAnswers[currentQuestion.id]?.contains(answ.id) ?? false,
                                        numberOfColumns: currentQuestion.numberOfColumns,
                                        onTapGesture: {
                                            store.dispatch(
                                                action: .quiz(
                                                    action: .selectAnswer(
                                                        questionId: currentQuestion.id,
                                                        answerId: answ.id
                                                    )
                                                )
                                            )
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
                ReusableButton(
                    text: "CONTINUE",
                    action: {
                        store.dispatch(action: .quiz(action: .nextQuestion))
                    },
                    foregroundColor: .white,
                    backgroundColor: .black,
                    size: 14,
                    cornerRadius: 0
                )
                .padding(.bottom, 10)
                .disabled(
                    quizState.selectedAnswers[currentQuestion.id]?.count ?? 0 < currentQuestion.minSelection
                )
            }
            .padding()
            .background(Color.white)
            .navigationBarTitle(Text(currentQuestion.screenName), displayMode: .inline)
            .navigationBarItems(leading: Group {
                if currentQuestion.id > 1 {
                    Button(action: {
                        store.dispatch(action: .quiz(action: .prevQuestion))
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
            })
            .tint(.black)
        }
    }
}
