//
//  UINavigationController+Extensions.swift
//
//  Created by Joachim Kret on 05.10.2015.
//  Copyright © 2015 Joachim Kret. All rights reserved.
//

import UIKit

extension UINavigationController: Autorotatable {
    private struct Static {
        static var token: dispatch_once_t = 0
        static var AutorotationMode = "AutorotationMode"
    }
    
    // MARK: Swizzle
    
    public override class func initialize() {
        // make sure this isn't a subclass
        if self !== UINavigationController.self {
            return
        }
        
        dispatch_once(&Static.token) {
            swizzleInstanceMethod(self, sel1: "shouldAutorotate", sel2: "swizzled_shouldAutorotate")
            swizzleInstanceMethod(self, sel1: "supportedInterfaceOrientations", sel2: "swizzled_supportedInterfaceOrientations")
        }
    }
    
    // MARK: Accessors
    
    var autorotation: Autorotation {
        get {
            if let autorotationMode = objc_getAssociatedObject(self, &Static.AutorotationMode) as? Int {
                return Autorotation(rawValue: autorotationMode)!
            } else {
                return Autorotation.Container
            }
        }
        
        set {
            objc_setAssociatedObject(self, &Static.AutorotationMode, newValue.rawValue as Int?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: Swizzled Rotation Methods
    
    func swizzled_shouldAutorotate() -> Bool {
        switch autorotation {
        case .Container:
            return self.swizzled_shouldAutorotate()
            
        case .ContainerAndTopChildren:
            if let topViewController = topViewController {
                return topViewController.shouldAutorotate()
            } else {
                return true
            }
            
        case .ContainerAndAllChildren:
            for viewController in viewControllers.reverse() {
                if !viewController.shouldAutorotate() {
                    return false
                }
            }
            
            return true
        }
    }
    
    func swizzled_supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        var mask = UIInterfaceOrientationMask.All.rawValue
        
        switch autorotation {
        case .Container:
            mask = self.swizzled_supportedInterfaceOrientations().rawValue
            
        case .ContainerAndTopChildren:
            if let topViewController = topViewController {
                mask &= topViewController.supportedInterfaceOrientations().rawValue
            }
            
        case .ContainerAndAllChildren:
            for viewController in viewControllers.reverse() {
                mask &= viewController.supportedInterfaceOrientations().rawValue
            }
        }
        
        return UIInterfaceOrientationMask(rawValue: mask)
    }
}
