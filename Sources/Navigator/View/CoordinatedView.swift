//
//  CoordinatedView.swift
//  Navigator
//
//  Created by Stephen Wojcik on 22/05/2024.
//

import SwiftUI

public struct RootCoordinatedScreenView<Content: View>: View {
    
    @StateObject var navigator: SwiftUINavigator
    private let content: Content
    
    init(
        navigator: SwiftUINavigator,
        content: @autoclosure () -> Content
    ) {
        self._navigator = StateObject(wrappedValue: navigator)
        self.content = content()
    }
    
    public var body: some View {
        NavigationStack(path: $navigator.navigationPath) {
            content
                .sheet(
                    isPresented: Binding(
                        get: { navigator.presentation == .sheet },
                        set: { _ in navigator.stopPresenting() }
                    ),
                    onDismiss: { navigator.onPresentedDismissed() },
                    content: navigator.presentationView
                )
#if !os(macOS)
                .fullScreenCover(
                    isPresented: Binding(
                        get: { navigator.presentation == .fullScreenCover },
                        set: { _ in navigator.stopPresenting() }
                    ),
                    onDismiss: { navigator.onPresentedDismissed() },
                    content: navigator.presentationView
                )
#endif
                .navigationDestination(for: Destination.self) { destination in
                    navigator.pushedViews[destination]?()
                }
        }
    }
}

struct ChildCoordinatedScreenView<Content: View>: View {
    
    @StateObject var navigator: SwiftUINavigator
    private let content: Content
    
    init(
        navigator: SwiftUINavigator,
        content: @autoclosure () -> Content
    ) {
        self._navigator = StateObject(wrappedValue: navigator)
        self.content = content()
    }
    
    var body: some View {
        content
            .sheet(
                isPresented: Binding(
                    get: { navigator.presentation == .sheet },
                    set: { _ in navigator.stopPresenting() }
                ),
                onDismiss: { navigator.onPresentedDismissed() },
                content: navigator.presentationView
            )
#if !os(macOS)
            .fullScreenCover(
                isPresented: Binding(
                    get: { navigator.presentation == .fullScreenCover },
                    set: { _ in navigator.stopPresenting() }
                ),
                onDismiss: { navigator.onPresentedDismissed() },
                content: navigator.presentationView
            )
#endif
    }
}
