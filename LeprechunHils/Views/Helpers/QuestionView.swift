//
//  QuestionView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct QuestionView: View {
    var text: String
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.questionLeprecon)
                .resizable()
                .frame(width: 260, height: 220)
                .padding(.bottom, 100)
            ZStack {
                Image(.backQuestion)
                    .resizable()
                    .frame(width: 350, height: 140)
                VStack{
                    Text("Question")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.greenApp)
                    Text(text)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                .minimumScaleFactor(0.5)
                .padding(20)
            }
        }
    }
}

#Preview {
    QuestionView(text: "Which animal is known as the king of the jungle?")
}
