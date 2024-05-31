//
//  CoordinatedView+Factory.swift
//  Navigator
//
//  Created by Stephen Wojcik on 28/05/2024.
//

import SwiftUI

public extension View {
    func root(navigator: SwiftUINavigator = .makeRoot()) -> RootCoordinatedScreenView<Self> {
        return RootCoordinatedScreenView(navigator: navigator, content: self)
    }
}

internal extension View {
    func presented(navigator: SwiftUINavigator) -> some View {
        return RootCoordinatedScreenView(navigator: navigator, content: self)
    }
    
    func pushed(navigator: SwiftUINavigator) -> some View {
        return ChildCoordinatedScreenView(navigator: navigator, content: self)
    }
}
