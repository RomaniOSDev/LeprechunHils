//
//  StoriCellView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 08.01.2026.
//

import SwiftUI

struct StoriCellView: View {
    var stori: Stories
    var body: some View {
        ZStack{
            Image(.backToOnboardText)
                .resizable()
            HStack{
                VStack(alignment: .leading){
                    Text("Reading")
                        .foregroundStyle(.black)
                    Text(stori.title)
                        .foregroundStyle(.greenApp)
                        .multilineTextAlignment(.leading)
                   
                }
                .font(.title2)
                .bold()
                .monospaced()
                .minimumScaleFactor(0.5)
                .padding()
                Spacer()
            Image(.storiLepricon)
                .resizable()
                .aspectRatio(contentMode: .fit)
            }.padding()
        }.frame(maxHeight: 170)
    }
}

#Preview {
    StoriCellView(stori: Stories.long)
}
