//
//  HomeViewFactory.swift
//  Example
//
//  Created by Stephen Wojcik on 30/05/2024.
//

import SwiftUI
import Navigator

class HomeViewFactory {
    func make() -> RootCoordinatedScreenView<HomeView> {
        let navigator = SwiftUINavigator.makeRoot()
        return HomeView(
            viewModel: HomeViewModel(
                onNextPageTapped: {
                    navigator.push(destination: NextPageViewFactory().make(navigator:))
                },
                onSettingsTapped: {
                    navigator.present(destination: SettingsViewFactory().make(navigator:))
                }
            )
        )
        .root(navigator: navigator)
    }
}
