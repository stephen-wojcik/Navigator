//
//  SwiftUINavigator+Factory.swift
//  Navigator
//
//  Created by Stephen Wojcik on 30/05/2024.
//

public extension SwiftUINavigator {
    static func makeRoot() -> SwiftUINavigator {
        return SwiftUINavigator(navigationContext: .root())
    }
}
