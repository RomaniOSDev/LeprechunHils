//
//  AwardSimpleView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 07.01.2026.
//

import SwiftUI

struct AwardSimpleView: View {
    var award: Awards
    var isEarned: Bool
    
    var body: some View {
        ZStack{
            Image(.backToOnboardText)
                .resizable()
            VStack{
                Image(award.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(isEarned ? 1.0 : 0.3)
                Text(award.title)
                    .foregroundStyle(.black)
                    .bold()
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }.padding()
        }
        .frame(maxHeight: 210)
        .overlay(
            Group {
                if !isEarned {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                }
            }
        )
    }
}


