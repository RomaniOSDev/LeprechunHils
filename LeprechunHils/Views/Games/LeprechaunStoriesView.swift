//
//  LeprechaunStoriesView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct LeprechaunStoriesView: View {
    var body: some View {
        ZStack{
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            VStack{
                ScrollView{
                    ForEach(Stories.allCases, id: \.self) { stori in
                        NavigationLink {
                           SimpleStoryView(stori: stori)
                        } label: {
                            StoriCellView(stori: stori)
                        }
                        
                        
                    }
                }
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
    LeprechaunStoriesView()
}

enum Stories: CaseIterable{
    case lost
    case loved
    case long
    case promise
    case quiet
    
    var image: ImageResource{
        switch self {
        case .lost: return .lost
        case .loved: return .loved
        case .long: return .long
        case .promise: return .promise
        case .quiet: return .quiet
        }
    }
    
    var text: String{
        switch self {
        case .lost: return "A small leprechaun lived at the edge of a deep green forest.  Every tree in this forest could whisper, but only if you listened very carefully. One morning, the leprechaun walked along a narrow path and heard a soft voice calling his name.  The trees were worried — the river in the forest was drying up. The leprechaun followed the sound to the old stones near the hills. There he found leaves blocking the water.  He cleared the path, and the river began to flow again. The forest became quiet and happy.  That night, the trees whispered their thanks, and the leprechaun fell asleep with a smile."
        case .loved: return "This leprechaun loved stories more than gold or magic. Every evening, he sat by the fire and told stories to the forest animals. One day, he forgot all his stories. His mind felt empty. He became sad and quiet. The animals decided to help.  The bird told him a story about the sky, the deer spoke about the mountains, and the fox shared a story of courage. Slowly, the leprechaun remembered that stories live everywhere.  From that day on, he listened more than he spoke — and his stories became even better."
        case .long: return "Winter came early that year. Snow covered the forest, and the nights were very cold.  The leprechaun worried about the plants and small creatures. Every day, he walked through the snow, checking the forest.  He helped animals find warm places and cleared paths after the storms. When spring finally arrived, flowers grew faster than ever before.  The forest was strong because someone had cared for it. The leprechaun learned that quiet help can be more powerful than magic."
        case .promise: return "Once, the leprechaun promised to protect a young tree near the hills. The tree was small and weak, and strong winds often came. Each time a storm arrived, the leprechaun stayed near the tree.  He built stones around it and spoke softly to calm it. Years passed. The tree grew tall and strong.  One day, it protected the leprechaun from the rain with its wide branches. The leprechaun smiled.  Promises, he learned, grow just like trees."
        case .quiet: return "High above the forest was a quiet hill. The leprechaun climbed it when he needed to think.  One evening, he sat there and watched the sky change colors.  He thought about the forest, the animals, and the long days behind him. In the silence, he felt peaceful.  He understood that not every moment needs action — some moments need rest. The leprechaun walked back home slowly, carrying calm in his heart."
        }
    }
    
    var title: String{
        switch self {
        case .lost: return "The Leprechaun and the Lost Hat"
        case .loved: return "The Leprechaun Who Loved Stories"
        case .long: return "The Leprechaun and the Long Winter"
        case .promise: return "The Leprechaun’s Promise"
        case .quiet: return "The Leprechaun and the Quiet Hill"
        }
    }
}
