//
//  OnbordingView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct OnbordingView: View {
    @StateObject var vm = OnBordingViewModel()
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            ZStack(alignment: .bottom) {
                Image(vm.currentPage.image)
                    .resizable()
                VStack{
                    ZStack {
                        Image(.backToOnboardText)
                            .resizable()
                        VStack {
                            Text(vm.currentPage.title)
                                .font(.largeTitle)
                                .bold()
                            Text(vm.currentPage.text)
                        }
                        .minimumScaleFactor(0.5)
                        .monospaced()
                        .multilineTextAlignment(.center)
                        .padding(30)
                    }
                    .frame(width: 350, height: 200)
                    Button {
                        vm.nextPage()
                    } label: {
                        ZStack {
                            Image(.backButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text("CONTINUE")
                                .font(Font.largeTitle.bold().monospaced())
                                .foregroundStyle(.black)
                        }
                    }

                }.padding()
            }
        }
        .fullScreenCover(isPresented: $vm.showMainScreen) {
            MainView()
        }
    }
}

#Preview {
    OnbordingView()
}
