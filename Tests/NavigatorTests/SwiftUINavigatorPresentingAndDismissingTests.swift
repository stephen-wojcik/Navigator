import XCTest
import SwiftUI
@testable import Navigator

final class SwiftUINavigatorPresentingAndDismissingTests: XCTestCase {
    
    @MainActor func test_present_setsRootStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        
        // WHEN
        rootNavigator.present { _ in EmptyView() }
        
        // THEN
        XCTAssertEqual(rootNavigator.presentation, .sheet)
    }
    
    @available(macOS, unavailable)
    @MainActor func test_presentFullScreenCover_setsRootStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        
        // WHEN
        rootNavigator.present(destination: { _ in EmptyView() }, as: .fullScreenCover)
        
        // THEN
        XCTAssertEqual(rootNavigator.presentation, .fullScreenCover)
    }
    
    @MainActor func test_present_makesThePresentedNavigatorCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        
        // WHEN
        var presentedNavigator: Navigator?
        rootNavigator.present { navigator in
            presentedNavigator = navigator
            return EmptyView()
        }
        
        // THEN
        XCTAssertTrue(presentedNavigator is SwiftUINavigator)
        XCTAssertIdentical(presentedNavigator?.parentNavigator, rootNavigator)
        XCTAssertEqual(presentedNavigator?.coordinationMethod, .presented)
    }
    
    @MainActor func test_stopPresenting_resetsRootStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        rootNavigator.present { _ in EmptyView() }
        
        // WHEN
        rootNavigator.stopPresenting()
        
        // THEN
        XCTAssertEqual(rootNavigator.presentation, .none)
    }
    
    @MainActor func test_dismiss_resetsThePresentingNavigatorsStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var presentedNavigator: Navigator?
        rootNavigator.present { navigator in
            presentedNavigator = navigator
            return EmptyView()
        }
        
        // WHEN
        presentedNavigator?.dismiss()
        
        // THEN
        XCTAssertEqual(rootNavigator.presentation, .none)
    }
}
