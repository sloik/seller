// system
import SwiftUI

protocol SizingFrameType {
    
    static var instance: SizingFrameType { get }
    
    var size: CGSize { get }
}

#if os(macOS)
import AppKit
public typealias PlatformScreen = NSScreen

extension NSScreen: SizingFrameType {
    
    static var instance: SizingFrameType {
        NSScreen.main!
    }
    
    public var size: CGSize {
        frame.size
    }
}

#else
import UIKit
public typealias PlatformScreen = UIScreen

extension UIScreen: SizingFrameType {
    static var instance: SizingFrameType {
        UIScreen.main
    }
    
    public var size: CGSize {
        bounds.size
    }
}

#endif
