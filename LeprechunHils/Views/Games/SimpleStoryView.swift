//
//  SimpleStoryView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 08.01.2026.
//

import SwiftUI

struct SimpleStoryView: View {
    var stori: Stories
    var body: some View {
        ZStack{
            Color.storiback
                .ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    Image(stori.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(stori.title)
                        .foregroundStyle(.greenApp)
                        .font(.title)
                        
                    Text(stori.text)
                }
                .bold()
                .monospaced()
            }.padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(.storiesLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    SimpleStoryView(stori: Stories.long)
}
