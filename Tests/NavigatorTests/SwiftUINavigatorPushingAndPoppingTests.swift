import XCTest
import SwiftUI
@testable import Navigator

final class SwiftUINavigatorPushingAndPoppingTests: XCTestCase {

    @MainActor func test_push_setsRootsStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        
        // WHEN
        let destinationId = rootNavigator.pushAndMakeView { _ in EmptyView() }
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, [destinationId])
        XCTAssertTrue(rootNavigator.pushedViews.keys.contains(destinationId))
        XCTAssertEqual(rootNavigator.pushedViews.count, 1)
    }
    
    @MainActor func test_push_makesThePushedNavigatorCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        
        // WHEN
        var pushedNavigator: Navigator?
        let destinationId = rootNavigator.pushAndMakeView { navigator in
            pushedNavigator = navigator
            return EmptyView()
        }
        
        // THEN
        XCTAssertTrue(pushedNavigator is SwiftUINavigator)
        XCTAssertIdentical(pushedNavigator?.parentNavigator, rootNavigator)
        XCTAssertEqual(pushedNavigator?.coordinationMethod, .pushed(destination: destinationId))
    }
    
    @MainActor func test_subsequentPush_setsRootsStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var pushedNavigator: Navigator?
        let firstDestinationId = rootNavigator.pushAndMakeView { navigator in
            pushedNavigator = navigator
            return EmptyView()
        }
        
        // WHEN
        let secondDestinationId = try XCTUnwrap(pushedNavigator?.push { _ in EmptyView() })
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, [firstDestinationId, secondDestinationId])
        XCTAssertTrue(rootNavigator.pushedViews.keys.contains(secondDestinationId))
        XCTAssertEqual(rootNavigator.pushedViews.count, 2)
    }
    
    @MainActor func test_subsequentPushes_setsRootsStateCorrectly() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        let numberOfSubsequentPushes = 10
        var destinationIds: [Destination?] = []
        var pushingNavigator: SwiftUINavigator? = rootNavigator
        
        // WHEN
        for _ in 0..<numberOfSubsequentPushes {
            destinationIds.append(
                pushingNavigator?.pushAndMakeView { navigator in
                    pushingNavigator = navigator as? SwiftUINavigator
                    return EmptyView()
                }
            )
        }
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, destinationIds)
        XCTAssertEqual(Set(rootNavigator.pushedViews.keys), Set(destinationIds))
        XCTAssertEqual(rootNavigator.pushedViews.count, numberOfSubsequentPushes)
    }
    
    @MainActor func test_popToRoot_viaRoot_removesAllPushedNavigatorsFromRoot() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var pushingNavigator: SwiftUINavigator? = rootNavigator
        for _ in 0..<10 {
            _ = pushingNavigator?.pushAndMakeView { navigator in
                pushingNavigator = navigator as? SwiftUINavigator
                return EmptyView()
            }
        }
        
        // WHEN
        rootNavigator.popToRoot()
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, [])
        XCTAssertEqual(rootNavigator.pushedViews.count, 0)
    }
    
    @MainActor func test_popToRoot_viaChild_removesAllPushedNavigatorsFromRoot() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var lastPushedNavigator: SwiftUINavigator?
        for _ in 0..<10 {
            _ = lastPushedNavigator?.pushAndMakeView { navigator in
                lastPushedNavigator = navigator as? SwiftUINavigator
                return EmptyView()
            }
        }
        
        // WHEN
        lastPushedNavigator?.popToRoot()
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, [])
        XCTAssertEqual(rootNavigator.pushedViews.count, 0)
    }
    
    @MainActor func test_popRemovingLast_viaRoot_removesLastGivenNumberOfPushedNavigatorsFromRoot() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var destinationIds: [Destination?] = []
        var pushingNavigator: SwiftUINavigator? = rootNavigator
        for _ in 0..<10 {
            destinationIds.append(
                pushingNavigator?.pushAndMakeView { navigator in
                    pushingNavigator = navigator as? SwiftUINavigator
                    return EmptyView()
                }
            )
        }
        
        // WHEN
        rootNavigator.pop(removingLast: 7)
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: 3)))
        XCTAssertEqual(rootNavigator.pushedViews.count, 3)
    }
    
    @MainActor func test_popRemovingLast_viaChild_removesLastGivenNumberOfPushedNavigatorsFromRoot() async throws {
        // GIVEN
        let rootNavigator = SwiftUINavigator.makeRoot()
        var destinationIds: [Destination?] = []
        var lastPushedNavigator: Navigator?
        var pushingNavigator: SwiftUINavigator? = rootNavigator
        for _ in 0..<10 {
            destinationIds.append(
                pushingNavigator?.pushAndMakeView { navigator in
                    lastPushedNavigator = navigator
                    pushingNavigator = navigator as? SwiftUINavigator
                    return EmptyView()
                }
            )
        }
        
        // WHEN
        lastPushedNavigator?.pop(removingLast: 7)
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: 3)))
        XCTAssertEqual(rootNavigator.pushedViews.count, 3)
    }
    
    @MainActor func test_popToNavigator_viaRoot_removesAllDestinationsUptoGivenNavigator() async throws {
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
        let indexToPopTo = 6
        rootNavigator.popTo(navigator: navigators[indexToPopTo])
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath.last, destinationIds[indexToPopTo])
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: indexToPopTo + 1)))
        XCTAssertEqual(rootNavigator.pushedViews.count, indexToPopTo + 1)
    }
    
    @MainActor func test_popToNavigator_viaChild_removesAllDestinationsUptoGivenNavigator() async throws {
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
        let indexToPopTo = 7
        navigators.last?.popTo(navigator: navigators[indexToPopTo])
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath.last, destinationIds[indexToPopTo])
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: indexToPopTo + 1)))
        XCTAssertEqual(rootNavigator.pushedViews.count, indexToPopTo + 1)
    }
    
    @MainActor func test_popToDestination_viaRoot_removesAllDestinationsUptoGivenDestination() async throws {
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
        let indexToPopTo = 3
        rootNavigator.popTo(destination: destinationIds.compactMap { $0 }[indexToPopTo])
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath.last, destinationIds[indexToPopTo])
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: indexToPopTo + 1)))
        XCTAssertEqual(rootNavigator.pushedViews.count, indexToPopTo + 1)
    }
    
    @MainActor func test_popToDestination_viaChild_removesAllDestinationsUptoGivenDestination() async throws {
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
        let indexToPopTo = 2
        navigators.last?.popTo(destination: destinationIds.compactMap { $0 }[indexToPopTo])
        
        // THEN
        XCTAssertEqual(rootNavigator.navigationPath.last, destinationIds[indexToPopTo])
        XCTAssertEqual(rootNavigator.navigationPath, Array(destinationIds.prefix(upTo: indexToPopTo + 1)))
        XCTAssertEqual(rootNavigator.pushedViews.count, indexToPopTo + 1)
    }
}
