//
//  LanternAnimatedTransitioning.swift
//  Lantern
//
//  Created by JiongXing on 2019/11/25.
//  Copyright © 2021 Shenzhen Hive Box Technology Co.,Ltd All rights reserved.
//

import UIKit

public protocol LanternAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    var isForShow: Bool { get set }
    var lantern: Lantern? { get set }
    var isNavigationAnimation: Bool { get set }
}

private var isForShowKey = "isForShowKey"
private var lanternKey = "lanternKey"

extension LanternAnimatedTransitioning {
    
    public var isForShow: Bool {
        get {
            if let value = objc_getAssociatedObject(self, &isForShowKey) as? Bool {
                return value
            }
            return true
        }
        set {
            objc_setAssociatedObject(self, &isForShowKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public weak var lantern: Lantern? {
        get {
            objc_getAssociatedObject(self, &lanternKey) as? Lantern
        }
        set {
            objc_setAssociatedObject(self, &lanternKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public var isNavigationAnimation: Bool {
        get { false }
        set { }
    }
    
    public func fastSnapshot(with view: UIView) -> UIView? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size, format: UIGraphicsImageRendererFormat.default())
        
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        }
        
        return UIImageView(image: image)
    }
    
    public func snapshot(with view: UIView) -> UIView? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)

        let image = renderer.image { context in
            let cgContext = context.cgContext
            view.layer.render(in: cgContext)
        }

        return UIImageView(image: image)
    }

}
