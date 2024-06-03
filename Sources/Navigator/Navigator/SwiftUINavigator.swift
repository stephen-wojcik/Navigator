//
//  SwiftUINavigator.swift
//  Navigator
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI

final public class SwiftUINavigator: ObservableObject, Navigator {
    
    public let coordinationMethod: CoordinationMethod
    private(set) weak var _parentNavigator: SwiftUINavigator?
    public var parentNavigator: Navigator? { return _parentNavigator }
    
    @Published @MainActor private(set) var presentation: PresentationStyle?
    @Published @MainActor var navigationPath: [Destination] = []
    
    @MainActor private(set) var presentationView: () -> AnyView = { noOpView }
    @MainActor private(set) var pushedViews: [Destination: () -> AnyView] = [:]
    
    public var onPresentedDismissed: @MainActor () -> Void = {}
    
    internal init(navigationContext: NavigationContext<SwiftUINavigator>) {
        self._parentNavigator = navigationContext.coordinatingNavigator
        self.coordinationMethod = navigationContext.coordinationMethod
    }
    
    @MainActor
    public func denavigate() {
        switch coordinationMethod {
        case .root:
            break
        case .pushed:
            pop()
        case .presented:
            dismiss()
        }
    }
    
    @MainActor
    public func rootNavigator() -> Navigator {
        findRootNavigator()
    }
    
    @MainActor
    public func findRootNavigator() -> SwiftUINavigator {
        var currentNavigator: SwiftUINavigator? = self
        while let navigator = currentNavigator {
            switch navigator.coordinationMethod {
            case .root:
                return navigator
            case .presented:
                return navigator
            case .pushed:
                currentNavigator = navigator._parentNavigator
            }
        }
        
        return self
    }
}

// MARK: Modal Presentation

public extension SwiftUINavigator {
    
    @MainActor
    func present(destination makeView: @escaping (Navigator) -> some View) {
        present(destination: makeView, as: .sheet)
    }
    
    @MainActor
    func present(
        destination makeView: @escaping (Navigator) -> some View,
        as presentation: PresentationStyle
    ) {
        let childNavigator = SwiftUINavigator(navigationContext: .presented(coordinatingNavigator: self))
        presentationView = {
            AnyView(
                makeView(childNavigator)
                    .presented(navigator: childNavigator)
            )
        }
        self.presentation = presentation
    }
    
    @MainActor
    func stopPresenting() {
        presentation = nil
        presentationView = { Self.noOpView }
    }
    
    @MainActor
    func dismiss() {
        guard let parentNavigator else {
            return
        }
        parentNavigator.stopPresenting()
    }
}

// MARK: Navigation Stack

public extension SwiftUINavigator {
    
    @discardableResult
    @MainActor
    func push(destination makeView: @escaping (Navigator) -> some View) -> Destination {
        let destination = Destination()
        let childNavigator = SwiftUINavigator(
            navigationContext: .pushed(
                coordinatingNavigator: self,
                destinationID: destination
            )
        )
        
        let root = findRootNavigator()
        root.pushedViews[destination] = {
            AnyView(
                makeView(childNavigator)
                    .pushed(navigator: childNavigator)
            )
        }
        root.navigationPath.append(destination)
        
        return destination
    }
    
    @MainActor
    func popToRoot() {
        let root = findRootNavigator()
        root.navigationPath.removeAll()
        root.tidyUpPushedViews()
    }
    
    @MainActor
    func pop(removingLast: Int = 1) {
        let root = findRootNavigator()
        root.navigationPath.removeLast(removingLast)
        root.tidyUpPushedViews()
    }
    
    @MainActor
    func pop() {
        pop(removingLast: 1)
    }
    
    @MainActor
    func popTo(navigator: Navigator) {
        switch navigator.coordinationMethod {
        case .root:
            popToRoot()
        case let .pushed(destination):
            popTo(destination: destination)
        case .presented:
            break
        }
        
        if navigator.parentNavigator == nil {
            popToRoot()
        }
    }
    
    @MainActor
    func popTo(destination: Destination) {
        let root = findRootNavigator()
        let separated = root.navigationPath.split(separator: destination)
        let tail = separated.last.flatMap(Array.init) ?? []
        root.navigationPath.removeAll(where: tail.contains)
        root.tidyUpPushedViews()
    }
}

// MARK: Private

private extension SwiftUINavigator {
    static var noOpView: AnyView {
        AnyView(erasing: EmptyView())
    }
    
    @MainActor
    func tidyUpPushedViews() {
        for pushedView in pushedViews {
            if !navigationPath.contains(pushedView.key) {
                pushedViews.removeValue(forKey: pushedView.key)
            }
        }
    }
}
