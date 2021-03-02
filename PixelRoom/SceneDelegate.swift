//
//  SceneDelegate.swift
//  PixelRoom
//
//  Created by Igor Lipovac on 01/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .dark
        window.rootViewController = createRootController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

// MARK: - Scene Creation

extension SceneDelegate {
    
    private func createRootController() -> UIViewController {
        let gallery = GalleryViewController()
        let navigationController = UINavigationController(rootViewController: gallery)
        navigationController.navigationBar.standardAppearance = navigationBarApperaance
        return navigationController
    }
    
    private var navigationBarApperaance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let backButtonAppearance = UIBarButtonItemAppearance()
        appearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().tintColor = .white
        return appearance
    }
}

