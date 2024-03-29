//
//  ChatApplicationApp.swift
//  ChatApplication
//
//  Created by Kieu Phu on 02/03/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ChatApplicationApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginView.ViewModel(loginUseCase: DefaultLoginUseCase(repository: ChatAuthenticationRepository(chatService: ChatService.shared))))
        }
    }
}
