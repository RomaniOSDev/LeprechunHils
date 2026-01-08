//
//  NewWordView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 07.01.2026.
//

import SwiftUI

struct NewWordView: View {
    var text: String
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.wordLeprecon)
                .resizable()
                .frame(width: 260, height: 280)
                .padding(.bottom, 100)
            ZStack {
                Image(.backQuestion)
                    .resizable()
                    .frame(width: 350, height: 140)
                VStack{
                    Text("New word for today")
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                    Text(text)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.greenApp)
                    
                }
                .padding(.top, 20)
                .minimumScaleFactor(0.5)
                .padding(20)
            }
        }
    }
}

#Preview {
    NewWordView(text: "Forest")
}
