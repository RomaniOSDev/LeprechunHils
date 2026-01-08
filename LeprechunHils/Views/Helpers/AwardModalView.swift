//
//  AwardModalView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct AwardModalView: View {
    let award: Awards
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 30) {
                Text("Congratulations!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                
                Text("You earned a new award!")
                    .font(.title2)
                    .foregroundColor(.black)
                
                ZStack {
                    Image(.backToOnboardText)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                    
                    AwardSimpleView(award: award, isEarned: true)
                    .padding()
                }
                
                Button {
                    isPresented = false
                } label: {
                    ZStack {
                        Image(.backButton)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 60)
                        
                        Text("Continue")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(40)
            .background(
                Image(.backToOnboardText)
                    .resizable()
                
            )
            .padding(40)
        }
    }
}

#Preview {
    AwardModalView(award: .rainbow, isPresented: .constant(true))
}


