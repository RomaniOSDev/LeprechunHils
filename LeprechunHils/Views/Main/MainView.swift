//
//  MainView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image(.mainBack)
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    //MARK: - Settings
                    HStack{
                        Spacer()
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(.settingsBTN)
                                .resizable()
                                .frame(width: 60, height: 50)
                        }

                    }
                    Spacer()
                    Image(.mainlabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ZStack(alignment: .bottom) {
                        Image(.mainLepricon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack{
                            NavigationLink {
                                GamesView()
                            } label: {
                                Image(.learnBTN)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            NavigationLink {
                                AwardsView()
                            } label: {
                                Image(.awardsBBTN)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }


                        }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    MainView()
}
