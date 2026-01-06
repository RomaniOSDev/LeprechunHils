//
//  ContentView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("ShowOnBording") var showOnBording: Bool?
    var body: some View {
        if showOnBording != nil {
            MainView()
        }else{
            OnbordingView()
        }
    }
}

#Preview {
    ContentView()
}
