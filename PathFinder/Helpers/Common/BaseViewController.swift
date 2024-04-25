//
//  BaseViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

class BaseViewController: UIViewController {
    func hideNavigationBar(animated: Bool = true) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func showNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func baseNavigationBarConfigurations() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundImage = UIImage(resource: .naviBarBckground)
            appearance.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.barTintColor = .white

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            var image = UIImage(resource: .naviBarBckground)
            image = image.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                              NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().titleTextAttributes = attributes
        }
    }

}
