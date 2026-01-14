//
//  SceneDelegate.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let controller: UIViewController = {
            let persistence = PersistenceManager.shared
            
            // Если ContentView был показан один раз, всегда показываем его
            if persistence.hasShownContentView {
                print("📱 ContentView был показан ранее, показываем ContentView")
                let swiftUIView = ContentView()
                return UIHostingController(rootView: swiftUIView)
            }
            
            // Если был успешный WebView загрузка и есть сохраненный URL, показываем WebView
            if persistence.hasSuccessfulWebViewLoad,
               let savedUrlString = persistence.savedUrl,
               let lastUrl = URL(string: savedUrlString),
               !savedUrlString.isEmpty {
                print("🌐 Last URL:", lastUrl)
                // Используем WebViewContainer для сохраненного URL
                let webViewContainer = WebViewContainer(
                    urlString: savedUrlString,
                    onFailure: {
                        // Если сохраненный URL недоступен, показываем ContentView
                        print("❌ Saved URL недоступен, показываем ContentView")
                        persistence.hasShownContentView = true
                    },
                    onSuccess: {
                        print("✅ Saved URL успешно загружен")
                    }
                )
                return UIHostingController(rootView: webViewContainer)
            } else {
                // Первый запуск - показываем LoadingSplash
                return LoadingSplash()
            }
        }()

        window.rootViewController = controller
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

