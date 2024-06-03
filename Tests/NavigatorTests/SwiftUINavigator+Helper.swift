@testable import Navigator
import SwiftUI

extension SwiftUINavigator {
    @MainActor func pushAndMakeView(destination makeView: @escaping (Navigator) -> some View) -> Destination {
        let destination = push(destination: makeView)
        _ = findRootNavigator().pushedViews[destination]?()
        return destination
    }
    
    @MainActor func presentAndMakeView(destination makeView: @escaping (Navigator) -> some View) {
        present(destination: makeView)
        _ = presentationView()
    }
    
    @MainActor func presentAndMakeView(destination makeView: @escaping (Navigator) -> some View, as presentationStyle: PresentationStyle) {
        present(destination: makeView, as: presentationStyle)
        _ = presentationView()
    }
}

