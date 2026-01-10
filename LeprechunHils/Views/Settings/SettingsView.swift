//
//  SettingsView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Image(.settingsLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                ZStack {
                    Image(.backToOnboardText)
                        .resizable()
                    VStack{
                        Button {
                            SKStoreReviewController.requestReview()
                        } label: {
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("Rate us")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                    .bold()
                            }
                        }
                        Button {
                            if let url = URL(string: "https://www.termsfeed.com/live/70da693f-574d-4e28-be25-1798e418f7dc") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("Policy")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                    .bold()
                            }
                        }
                        Button {
                            if let url = URL(string: "https://www.termsfeed.com/live/00eef081-47ba-4d8a-bcb2-17b85edd016c") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("Terms")
                                    .foregroundStyle(.black)
                                    .font(.title)
                                    .bold()
                            }
                        }

                        
                    }.padding(30)
                }
            }.padding()
        }
    }
}

#Preview {
    SettingsView()
}
