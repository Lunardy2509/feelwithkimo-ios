//
//  Size+ext.swift
//  feelwithkimo
//
//  Created by Richard Sugiharto on 30/10/25.
//
import SwiftUI

extension CGFloat {
    
    /// Function to dynamic based on design
    func getWidth(byBaseWidth baseWidth: CGFloat = 1194) -> CGFloat {
        return self * UIScreen.main.bounds.width / baseWidth
    }
    
    /// Function to dynamic height based on design
    func getHeight(byBaseHeight baseHeight: CGFloat = 834) -> CGFloat {
        return self * UIScreen.main.bounds.height / baseHeight
    }
}

extension BinaryInteger {
    func getWidth() -> CGFloat {
        return CGFloat(self) * UIScreen.main.bounds.width / 1194
    }
    
    /// Function to dynamic height based on design
    func getHeight(byBaseHeight baseHeight: CGFloat = 834) -> CGFloat {
        return CGFloat(self) * UIScreen.main.bounds.height / baseHeight
    }
}
