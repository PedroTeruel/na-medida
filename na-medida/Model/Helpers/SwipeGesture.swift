//
//  SwipeGesture.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 29/09/26.
//

import SwiftUI

class SwipeController: NSObject, UIGestureRecognizerDelegate {
    static let shared = SwipeController()
    var swipeAction: (() -> Bool)?
    weak var navigationController: UINavigationController?
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let n = navigationController, n.viewControllers.count <= 1 {
            return false
        }
        if let action = swipeAction {
            return action()
        }
        return true
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        SwipeController.shared.navigationController = self
        interactivePopGestureRecognizer?.delegate = SwipeController.shared
        
    }
    
}
