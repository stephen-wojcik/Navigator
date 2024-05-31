//
//  Navigator.swift
//  Navigator
//
//  Created by Stephen Wojcik on 23/05/2024.
//

import SwiftUI

public protocol Navigator: AnyObject {
    var coordinationMethod: CoordinationMethod { get }
    var parentNavigator: Navigator? { get }
    
    @MainActor func denavigate()
    @MainActor func rootNavigator() -> Navigator
    
    @MainActor func present(destination makeView: (Navigator) -> some View, as presentation: PresentationStyle)
    @MainActor func present(destination makeView: (Navigator) -> some View)
    @MainActor func stopPresenting()
    @MainActor func dismiss()
    
    @discardableResult @MainActor func push(destination makeView: (Navigator) -> some View) -> Destination
    @MainActor func popToRoot()
    @MainActor func pop(removingLast: Int)
    @MainActor func pop()
    @MainActor func popTo(navigator: Navigator)
    @MainActor func popTo(destination: Destination)
}
