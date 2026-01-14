//
//  TaskDetailView.swift
//  BubblyBass
//
//  Created by Роман Главацкий on 26.10.2025.
//

import UIKit
import SwiftUI

class LoadingSplash: UIViewController {

    let loadingLabel = UILabel()
    let loadingImage = UIImageView()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // Добавляем свойство для хранения Firebase URL
    private var firebaseURL: String?
    private var firebaseLoadCompleted = false
    private var appsFlyerDataReadyFlag = false
    private var contentViewShown = false
    private weak var presentedWebViewHostingController: UIHostingController<WebViewContainer>?
    
    private var didStartFlow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !didStartFlow else { return }
        didStartFlow = true
        setupFlow()
    }

    private func setupUI() {
        print("start setupUI")
        view.addSubview(loadingImage)
        loadingImage.image = UIImage(resource: .hellowIc)
        loadingImage.contentMode = .scaleAspectFit
        loadingImage.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(activityIndicator)
        
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingImage.topAnchor.constraint(equalTo: view.topAnchor),
            loadingImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupFlow() {
        activityIndicator.startAnimating()

        // Загружаем Firebase URL параллельно с ожиданием AppsFlyer
        loadFirebaseURL()
        
        if let savedURL = UserDefaults.standard.string(forKey: "finalAppsflyerURL") {
            print("Using existing AppsFlyer data")
            appsFlyerDataReady()
        } else {
            print("⌛ Waiting for AppsFlyer data...")

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(appsFlyerDataReady),
                name: Notification.Name("AppsFlyerDataReceived"),
                object: nil
            )

            // Таймаут на случай, если данные так и не придут
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                if !self.appsFlyerDataReadyFlag {
                    print("Timeout waiting for AppsFlyer. Proceeding with fallback.")
                    self.appsFlyerDataReady()
                }
            }
        }
    }
    
    // MARK: - Firebase Integration
    
    private func loadFirebaseURL() {
        Task { @MainActor in
            do {
                print("🔄 Загружаем URL из Firebase...")
                let urlString = try await FireBaseManager.shared.fetchTopRatesURL()
                print("✅ Firebase URL загружен: \(urlString)")
                self.firebaseURL = urlString
                self.firebaseLoadCompleted = true
                
                // Если AppsFlyer данные уже готовы, продолжаем поток
                if self.appsFlyerDataReadyFlag {
                    self.proceedWithFlow()
                }
                
            } catch {
                print("❌ Ошибка загрузки Firebase URL: \(error.localizedDescription)")
                self.firebaseURL = nil
                self.firebaseLoadCompleted = true
                
                // Если AppsFlyer данные уже готовы, продолжаем поток
                if self.appsFlyerDataReadyFlag {
                    self.proceedWithFlow()
                }
            }
        }
    }

    @objc private func appsFlyerDataReady() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AppsFlyerDataReceived"), object: nil)
        appsFlyerDataReadyFlag = true
        
        // Если Firebase уже загрузился (или завершился с ошибкой), продолжаем поток
        if firebaseLoadCompleted {
            proceedWithFlow()
        }
        // Иначе ждем завершения загрузки Firebase в loadFirebaseURL()
    }
    
    private func proceedWithFlow() {
        // Сначала проверяем Firebase URL, если он загружен
        if let firebaseURL = firebaseURL {
            openWebViewWithFirebaseURL(firebaseURL)
        } else {
            // Если Firebase URL не загружен, используем старую логику
            print("⚠️ Firebase URL недоступен, показываем SwiftUI контент")
            showSwiftUIContent()
        }
    }
    
    private func openWebViewWithFirebaseURL(_ urlString: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.restrictRotation = .all
        }
        activityIndicator.stopAnimating()
        
        // Используем Firebase URL как базовую ссылку и добавляем AppsFlyer параметры
        let finalURL = self.generateTrackingLinkWithFirebase(baseURL: urlString)
        
        // Используем WebViewContainer напрямую - он сам проверит статус код
        let webViewContainer = WebViewContainer(
            urlString: finalURL,
            onFailure: { [weak self] in
                DispatchQueue.main.async {
                    print("❌ WebView: URL недоступен, показываем SwiftUI контент")
                    self?.showSwiftUIContent()
                }
            },
            onSuccess: { [weak self] in
                DispatchQueue.main.async {
                    print("✅ WebView: URL успешно загружен")
                    // WebView уже открыт и загружен, ничего не делаем
                }
            }
        )
        
        let hostingController = UIHostingController(rootView: webViewContainer)
        hostingController.modalPresentationStyle = .fullScreen
        self.presentedWebViewHostingController = hostingController
        self.present(hostingController, animated: true)
    }
    
    
    private func showSwiftUIContent() {
        // Предотвращаем двойной показ
        guard !contentViewShown else {
            print("⚠️ ContentView уже показан, пропускаем")
            return
        }
        
        contentViewShown = true
        
        // Устанавливаем флаг, что ContentView был показан
        PersistenceManager.shared.hasShownContentView = true
        
        // Если есть presented WebView, сначала dismiss его
        if let presentedController = presentedWebViewHostingController {
            presentedController.dismiss(animated: false) { [weak self] in
                self?.presentContentView()
            }
        } else {
            // Если нет presented controller, показываем напрямую
            presentContentView()
        }
    }
    
    private func presentContentView() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.restrictRotation = .portrait
        }
        activityIndicator.stopAnimating()
        let swiftUIView = ContentView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
        
        // Используем rootViewController для показа, если мы не в window hierarchy
        if let windowScene = view.window?.windowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(hostingController, animated: true)
        } else {
            // Fallback - показываем из текущего контроллера
            self.present(hostingController, animated: true)
        }
    }
    
    // Генерация ссылки с Firebase URL как базой
    func generateTrackingLinkWithFirebase(baseURL: String) -> String {
        if let savedURL = UserDefaults.standard.string(forKey: "finalAppsflyerURL") {
            // Убираем первый "?" из AppsFlyer параметров, если он есть
            var appsflyerParams = savedURL.trimmingCharacters(in: .whitespaces)
            if appsflyerParams.hasPrefix("?") {
                appsflyerParams = String(appsflyerParams.dropFirst())
            }
            
            // Если есть AppsFlyer параметры, добавляем их к Firebase URL
            let separator = baseURL.contains("?") ? "&" : "?"
            let full = baseURL + separator + appsflyerParams
            print("Generated tracking link with Firebase: \(full)")
            return full
        } else {
            // Если нет AppsFlyer параметров, используем чистый Firebase URL
            print("AppsFlyer data not available, using Firebase URL only: \(baseURL)")
            return baseURL
        }
    }
    
}
