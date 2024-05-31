//
//  NavigationContext.swift
//  Navigator
//
//  Created by Stephen Wojcik on 28/05/2024.
//

struct NavigationContext<NavigatorType: Navigator> {
    var coordinatingNavigator: NavigatorType?
    var coordinationMethod: CoordinationMethod
}

extension NavigationContext {
    static func root() -> Self {
        NavigationContext(
            coordinatingNavigator: nil,
            coordinationMethod: .root
        )
    }
    
    static func pushed(
        coordinatingNavigator: NavigatorType,
        destinationID: Destination
    ) -> Self {
        NavigationContext(
            coordinatingNavigator: coordinatingNavigator,
            coordinationMethod: .pushed(destination: destinationID)
        )
    }
    
    static func presented(
        coordinatingNavigator: NavigatorType
    ) -> Self {
        NavigationContext(
            coordinatingNavigator: coordinatingNavigator,
            coordinationMethod: .presented
        )
    }
}
