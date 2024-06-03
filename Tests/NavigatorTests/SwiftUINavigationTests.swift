import XCTest
import SwiftUI
@testable import Navigator

final class SwiftUINavigationTests: XCTestCase {
    
    @MainActor func test_rootNavigator_isRootNavigator() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        
        // THEN
        XCTAssertIdentical(rootNavigator.rootNavigator(), rootNavigator)
    }
    
    @MainActor func test_rootNavigator_ofPresentedView_isThePresentedView() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var presentedNavigator: Navigator?
        rootNavigator.presentAndMakeView { navigator in
            presentedNavigator = navigator
            return EmptyView()
        }
        
        // THEN
        XCTAssertIdentical(presentedNavigator?.rootNavigator(), presentedNavigator)
    }
    
    @MainActor func test_rootNavigator_ofPushedView_isThePresentedView() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var pushedNavigator: Navigator?
        var pushingNavigator: SwiftUINavigator? = rootNavigator
        for _ in 0..<10 {
            _ = pushingNavigator?.pushAndMakeView { navigator in
                pushedNavigator = navigator
                pushingNavigator = navigator as? SwiftUINavigator
                return EmptyView()
            }
        }
        
        // THEN
        XCTAssertIdentical(pushedNavigator?.rootNavigator(), rootNavigator)
    }
    
    @MainActor func test_denavigateFromPresentedView() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var presentedNavigator: Navigator?
        rootNavigator.presentAndMakeView { navigator in
            presentedNavigator = navigator
            return EmptyView()
        }
        
        // WHEN
        presentedNavigator?.denavigate()
        
        // THEN
        XCTAssertEqual(rootNavigator.presentation, .none)
    }
    
    @MainActor func test_denavigateFromPushedView() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var destinationIds: [Destination?] = []
        var navigators: [Navigator] = []
        var pushingNavigator: SwiftUINavigator? = rootNavigator
        for _ in 0..<10 {
            destinationIds.append(
                pushingNavigator?.pushAndMakeView { navigator in
                    navigators += [navigator]
                    pushingNavigator = navigator as? SwiftUINavigator
                    return EmptyView()
                }
            )
        }
        
        // WHEN
        navigators.last?.denavigate()
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath.last, destinationIds[8])
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: 9)))
        XCTAssertEqual(rootNavigator.pushedViews.count, 9)
    }
}
