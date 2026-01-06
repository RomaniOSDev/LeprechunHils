//
//  GamesView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Image(.selectActionLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                VStack(spacing: 15){
                    //MARK: - Magic word
                    NavigationLink {
                        MagicWordView()
                    } label: {
                        Image(.magicWordBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    //MARK: - Raibow quiz
                    NavigationLink {
                        RainBowQuizView()
                    } label: {
                        Image(.quizBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    //MARK: - Match Clover
                    NavigationLink {
                        MatchCloverView()
                    } label: {
                        Image(.matchBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    //MARK: - Leprechaun Stories
                    NavigationLink {
                        LeprechaunStoriesView()
                    } label: {
                        Image(.storiesBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }

                }
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    GamesView()
}
